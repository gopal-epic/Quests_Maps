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
        
//        addLineShapeLayer()
    }
    
    func addLineShapeLayer() {
        guard let node1BaseView = questObjectiveView1.nodeBaseView,
              let node2BaseView = questObjectiveView2.nodeBaseView
              else { return }
        
        linePath = QuestMapAlgorithm.determineBeizerPath(from: node1BaseView, node2View: node2BaseView)
        
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

