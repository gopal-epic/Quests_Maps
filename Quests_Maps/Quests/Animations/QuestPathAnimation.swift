//
//  QuestPathAnimation.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestPathAnimation: CABasicAnimation {
    
    enum AnimationType: String {
        case dottedToThickLine = "strokeEnd"
        case none = ""
    }
    
    // MARK: - Init Methods
    
    class func add(for layer: CAShapeLayer, animationType: AnimationType, delegate: CAAnimationDelegate? = nil) {
        let lineAnimation = CABasicAnimation(keyPath: animationType.rawValue)
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1
        lineAnimation.duration = 0.90
        lineAnimation.repeatCount = 0
        lineAnimation.delegate = delegate
        
        layer.add(lineAnimation, forKey: "linePath")
    }
}
