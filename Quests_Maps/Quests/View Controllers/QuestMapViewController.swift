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
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var questPathView: UIView!
    @IBOutlet weak var questObjectivesView: UIView!
    @IBOutlet weak var animateButton: UIButton!
    
    @IBOutlet weak var questObjectivesViewWidth: NSLayoutConstraint!
    
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
        
        questObjectivesViewWidth.constant = view.bounds.size.width
        
        fetchQuestObjectives()
        addQuestObjectives()
        addDottedLine()
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
    
    func addQuestObjectives() {
        guard let objectiveModels = objectiveModels else { return }
        
        var previousObjectiveView: QuestObjectiveView?
        objectiveViews = [QuestObjectiveView]()
        var dottedLine: UIBezierPath?
        var objectiveViewsWidth: CGFloat = 0
        
        for currentObjectiveModel in objectiveModels {
            if currentObjectiveModel.nodeType == QuestObjectiveModel.NodeType.finish {
                let finishView = QuestFinishView.init(frame: currentObjectiveModel.position)
                
                questObjectivesView.addSubview(finishView)
                
                if let previousObjectiveView = previousObjectiveView {
                    dottedLine = QuestMapAlgorithm.determineBeizerPath(from: previousObjectiveView.frameInQuestMap, node1Center: previousObjectiveView.centerInQuestMap, to: finishView.frame, node2Center: finishView.center, finishNode: true)
                }
                
                objectiveViewsWidth = (finishView.frame.origin.x + finishView.frame.size.width + 40)
            } else {
                let currentObjectiveView = QuestObjectiveView.init(frame: currentObjectiveModel.position, objectiveModel: currentObjectiveModel)
                
                questObjectivesView.addSubview(currentObjectiveView)
                
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
        
        if objectiveViewsWidth > questObjectivesViewWidth.constant {
            questObjectivesViewWidth.constant = objectiveViewsWidth
        }
    }
    
    func addDottedLine() {
        guard let linePath = linePath else { return }
        
        shapeLayer = QuestPath.init(path: linePath.cgPath, pathType: QuestPath.PathType.dottedLine)
        guard let shapeLayer = shapeLayer else { return }
        
        questPathView.layer.addSublayer(shapeLayer)        
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
