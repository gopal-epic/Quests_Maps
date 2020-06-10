//
//  QuestMapViewController.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

protocol QuestObjectivesDelegate: AnyObject {
    func didSelectQuestObjective(with id: String)
}

class QuestMapViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var questPathView: UIView!
    @IBOutlet weak var animateButton: UIButton!
    
    // MARK: - Var & Constants
    
    static var tabbedNibName: String { return "QuestMapViewController" }
    
    weak var delegate: QuestObjectivesDelegate?
    
    var shapeLayer: CAShapeLayer?
    var linePath: UIBezierPath?
    var objectiveModels: [QuestObjectiveModel]?
    var objectiveViews: [QuestObjectiveView]?
    
    @IBAction func animateButtonAction(_ sender: UIButton) {
        playLineAnimation()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuestObjectives()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addQuestObjectivesToContentView()
        addDottedLineToQuestPathView()
    }
    
    func fetchQuestObjectives() {
        objectiveModels = [QuestObjectiveModel]()
        let count = 4
        
        for i in 0..<count {
            let state = (i == 0 ? QuestObjectiveModel.State.inProgress : QuestObjectiveModel.State.notStarted)
            let previousXValue: CGFloat
            if i == 0 {
                previousXValue = 0
            } else {
                guard let objectiveModels = objectiveModels else { continue }
                
                let previousObjectiveModel = objectiveModels[i - 1]
                previousXValue = previousObjectiveModel.position.origin.x
            }
            
            let objectiveModel = QuestObjectiveModel(currentIndex: i, objectivesCount: count, withBuddy: false, objectiveState: state, previousXVal: previousXValue)
            objectiveModels?.append(objectiveModel)
        }
    }
    
    func addQuestObjectivesToContentView() {
        guard let objectiveModels = objectiveModels else { return }
        
        var previousObjectiveView: QuestObjectiveView?
        objectiveViews = [QuestObjectiveView]()
        
        var dottedLine: UIBezierPath?
        
        for currentModel in objectiveModels {
            if currentModel.nodeType == QuestObjectiveModel.NodeType.finish {
                let finishView = QuestFinishView.init(frame: currentModel.position)
                
                contentView.addSubview(finishView)
                
                if let previousObjectiveView = previousObjectiveView {
                    dottedLine = QuestMapAlgorithm.determineBeizerPath(from: previousObjectiveView.frameInQuestMap, node1Center: previousObjectiveView.centerInQuestMap, to: finishView.frame, node2Center: finishView.center, finishNode: true)
                }
                
                scrollView.contentSize = CGSize(width: (finishView.frame.origin.x + finishView.frame.size.width + 40), height: contentView.frame.size.height)
            } else {
                let currentObjectiveView = QuestObjectiveView.init(frame: currentModel.position)
                
                if currentModel.isFirstNode {
                    currentObjectiveView.starBustLottieView.isHidden = false
                    currentObjectiveView.nodeBaseImageView.image = UIImage.init(named: "quest-node-active-base")
                    currentObjectiveView.nodeBaseActiveEclipseImageView.isHidden = false
                    currentObjectiveView.nodeBaseActiveNumberLabel.text = "1"
                    currentObjectiveView.nodeActiveMarkerOrBuddyView.isHidden = false
                }
                
                contentView.addSubview(currentObjectiveView)
                
                if let previousObjectiveView = previousObjectiveView {
                    dottedLine = QuestMapAlgorithm.determineBeizerPath(from: previousObjectiveView.frameInQuestMap, node1Center: previousObjectiveView.centerInQuestMap, to: currentObjectiveView.frameInQuestMap, node2Center: currentObjectiveView.centerInQuestMap, finishNode: false)
                }
                
                previousObjectiveView = currentObjectiveView
            }
            
            guard let dottedLine = dottedLine else { continue }
            
            if linePath == nil {
                linePath = dottedLine
            } else {
                linePath?.append(dottedLine)
            }
        }
    }
    
    func addDottedLineToQuestPathView() {
        guard let linePath = linePath else { return }
        
        shapeLayer = QuestPath.init(path: linePath.cgPath, pathType: QuestPath.PathType.dottedLine)
        guard let shapeLayer = shapeLayer else { return }
        
        questPathView.layer.addSublayer(shapeLayer)
        
        contentView.bringSubviewToFront(animateButton)
    }
    
    func playLineAnimation() {
        guard let linePath = linePath,
              let shapeLayer = shapeLayer
              else { return }
        
        let shapeLayerTwo = QuestPath.init(path: linePath.cgPath, pathType: .thickLine)
        
        shapeLayer.addSublayer(shapeLayerTwo)
        
        QuestPathAnimation.add(for: shapeLayerTwo, animationType: QuestPathAnimation.AnimationType.dottedToThickLine, delegate: self)
    }
}

extension QuestMapViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            // finished animation
        }
    }
}
