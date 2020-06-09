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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var starBustImageView: UIImageView!
    @IBOutlet weak var flag1ImageView: UIImageView!
    @IBOutlet weak var marker1ImageView: UIImageView!
    @IBOutlet weak var marker2ImageView: UIImageView!
    @IBOutlet weak var animateButton: UIButton!
    
    @IBOutlet weak var questObjectiveView1: QuestObjectiveView!
    @IBOutlet weak var questObjectiveView2: QuestObjectiveView!
    @IBOutlet weak var questObjectiveView3: QuestObjectiveView!
    
    weak var delegate: QuestObjectivesDelegate?
    
    var shapeLayer = CAShapeLayer()
    var linePath: UIBezierPath!
    
    @IBAction func animateButtonAction(_ sender: UIButton) {
        marker1ImageView.fadeOut(completion: {
            (finished: Bool) -> Void in
            self.marker1ImageView.removeFromSuperview()
            
            self.flag1ImageView.fadeIn { (finished: Bool) -> Void in
                self.playLineAnimation()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questObjectiveView1.starBustLottieView.isHidden = false
        questObjectiveView1.nodeBaseImageView.image = UIImage.init(named: "quest-node-active-base")
        questObjectiveView1.nodeBaseActiveEclipseImageView.isHidden = false
        questObjectiveView1.nodeBaseActiveNumberLabel.text = "1"
        questObjectiveView1.nodeActiveMarkerOrBuddyView.isHidden = false
        
        addLineShapeLayer()
    }
    
    func addLineShapeLayer() {
        let linePath1 = QuestMapAlgorithm.determineLeftToRightBeizerPath(from: questObjectiveView1.frameInQuestMap, node1Center: questObjectiveView1.centerInQuestMap, to: questObjectiveView2.frameInQuestMap, node2Center: questObjectiveView2.centerInQuestMap)
        
        let linePath2 = QuestMapAlgorithm.determineRightToLeftBeizerPath(from: questObjectiveView2.frameInQuestMap, node1Center: questObjectiveView2.centerInQuestMap, to: questObjectiveView3.frameInQuestMap, node2Center: questObjectiveView3.centerInQuestMap)
        
        linePath = linePath1
        linePath.append(linePath2)
        
        shapeLayer = QuestPath.init(path: linePath.cgPath, pathType: QuestPath.PathType.dottedLine)
        
        contentView.layer.addSublayer(shapeLayer)
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
            self.starBustImageView.fadeIn { (finished: Bool) -> Void in
                self.marker2ImageView.fadeIn()
            }
        }
    }
}

extension UIView {

    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
    }, completion: completion)  }

    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.3
    }, completion: completion)
   }
}

