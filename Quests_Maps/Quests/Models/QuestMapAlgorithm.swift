//
//  QuestMapAlgorithm.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestMapAlgorithm: NSObject {
    
    class func determineBeizerPath(from node1Frame: CGRect, node1Center: CGPoint, to node2Frame: CGRect, node2Center: CGPoint, finishNode: Bool) -> UIBezierPath {
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 20), y: node1Center.y + 20)
        
        let controlPoint = CGPoint(x: (node1Positon.x + 80), y: node1Positon.y)
        
        let endPoint = CGPoint(x: (node2Frame.origin.x + 50), y: (node2Center.y + 20))
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 80 - (finishNode ? 60 : 0)), y: (endPoint.y - (finishNode ? 30 : 0)))
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
}
