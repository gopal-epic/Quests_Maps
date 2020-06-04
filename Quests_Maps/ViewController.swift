//
//  ViewController.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var starBustImageView: UIImageView!
    @IBOutlet weak var node1ImageView: UIImageView!
    @IBOutlet weak var flag1ImageView: UIImageView!
    @IBOutlet weak var marker1ImageView: UIImageView!
    @IBOutlet weak var node2ImageView: UIImageView!
    @IBOutlet weak var marker2ImageView: UIImageView!
    @IBOutlet weak var animateButton: UIButton!
    
    let shapeLayer = CAShapeLayer()
    var linePath: UIBezierPath!
    var animatePathSoundEffect: AVAudioPlayer?
    
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
        
        addLineShapeLayer()
    }
    
    func addLineShapeLayer() {
        linePath = determineBeizerPathFromNode1ToNode2()
        
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 8.0
        shapeLayer.lineDashPattern = [16,10]
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func playLineAnimation() {
        let shapeLayerTwo = CAShapeLayer()
        shapeLayerTwo.path = linePath.cgPath
        shapeLayerTwo.strokeColor = UIColor.white.cgColor
        shapeLayerTwo.fillColor = UIColor.clear.cgColor
        shapeLayerTwo.lineWidth = 8.0
        
        shapeLayer.addSublayer(shapeLayerTwo)
        
        let lineAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1
        lineAnimation.duration = 0.60
        lineAnimation.repeatCount = 0
        lineAnimation.delegate = self
        
        shapeLayerTwo.add(lineAnimation, forKey: "line")
    }
    
    //MARK:- Custom Curve Path
    
    func determineBeizerPathFromNode1ToNode2() -> UIBezierPath {
        let node1Frame = node1ImageView.frame
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 4), y: (node1ImageView.center.y + 30))
        
        let controlPoint = CGPoint(x: (node1Positon.x + 60), y: node1Positon.y)
        
        let node2Frame = node2ImageView.frame
        let endPoint = CGPoint(x: (node2Frame.origin.x + 15), y: node2ImageView.center.y + 40)
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 60), y: ((endPoint.y + 40)))
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
    
    func playAnimatePathSound() {
        let path = Bundle.main.path(forResource: "animate_path.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            animatePathSoundEffect = try AVAudioPlayer(contentsOf: url)
            animatePathSoundEffect?.play()
        } catch {
            // couldn't load file :(
            print("couldn't load mp3 file")
        }
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        playAnimatePathSound()
    }
    
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


