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
    @IBOutlet weak var questObjectiveView1: QuestObjectiveView!
    @IBOutlet weak var questObjectiveView2: QuestObjectiveView!
    @IBOutlet weak var questObjectiveView3: QuestObjectiveView!
    @IBOutlet weak var questFinishView: QuestFinishView!
    
    // MARK: - Var & Constants
    
    static var tabbedNibName: String { return "QuestMapViewController" }
    
    weak var delegate: QuestObjectivesDelegate?
    
    var shapeLayer = CAShapeLayer()
    var linePath: UIBezierPath!
    var objectiveModels: [QuestObjectiveModel]?
    
    @IBAction func animateButtonAction(_ sender: UIButton) {
        playLineAnimation()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questObjectiveView1.starBustLottieView.isHidden = false
        questObjectiveView1.nodeBaseImageView.image = UIImage.init(named: "quest-node-active-base")
        questObjectiveView1.nodeBaseActiveEclipseImageView.isHidden = false
        questObjectiveView1.nodeBaseActiveNumberLabel.text = "1"
        questObjectiveView1.nodeActiveMarkerOrBuddyView.isHidden = false
        
        addLineShapeLayer()
        
        fetchQuestObjectives()
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
    
    func addLineShapeLayer() {
        let linePath1 = QuestMapAlgorithm.determineLeftToRightBeizerPath(from: questObjectiveView1.frameInQuestMap, node1Center: questObjectiveView1.centerInQuestMap, to: questObjectiveView2.frameInQuestMap, node2Center: questObjectiveView2.centerInQuestMap)
        
        let linePath2 = QuestMapAlgorithm.determineRightToLeftBeizerPath(from: questObjectiveView2.frameInQuestMap, node1Center: questObjectiveView2.centerInQuestMap, to: questObjectiveView3.frameInQuestMap, node2Center: questObjectiveView3.centerInQuestMap)
        
        let linePath3 = QuestMapAlgorithm.determineFinishBeizerPath(from: questObjectiveView3.frameInQuestMap, node1Center: questObjectiveView3.centerInQuestMap, to: questFinishView.frame, node2Center: questFinishView.center)
        
        linePath = linePath1
        linePath.append(linePath2)
        linePath.append(linePath3)
        
        shapeLayer = QuestPath.init(path: linePath.cgPath, pathType: QuestPath.PathType.dottedLine)
        
        questPathView.layer.addSublayer(shapeLayer)
    }
    
    func playLineAnimation() {
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
