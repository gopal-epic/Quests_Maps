//
//  QuestMapAlgorithm.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestMapAlgorithm: NSObject {
    
    class func determineLeftToRightBeizerPath(from node1Frame: CGRect, node1Center: CGPoint, to node2Frame: CGRect, node2Center: CGPoint) -> UIBezierPath {
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 4), y: (node1Center.y + 20))
        
        let controlPoint = CGPoint(x: (node1Positon.x + 60), y: node1Positon.y)
        
        let endPoint = CGPoint(x: (node2Frame.origin.x + 10), y: (node2Center.y + 20))
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 60), y: (endPoint.y + 40))
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
    
    class func determineRightToLeftBeizerPath(from node1Frame: CGRect, node1Center: CGPoint, to node2Frame: CGRect, node2Center: CGPoint) -> UIBezierPath {
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 4), y: (node1Center.y + 10))
        
        let controlPoint = CGPoint(x: (node1Positon.x + 30), y: node1Positon.y)
        
        let endPoint = CGPoint(x: (node2Frame.origin.x + 10), y: (node2Center.y + 10))
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 40), y: endPoint.y)
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
    
    class func determineFinishBeizerPath(from node1Frame: CGRect, node1Center: CGPoint, to node2Frame: CGRect, node2Center: CGPoint) -> UIBezierPath {
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 4), y: node1Center.y + 10)
        
        let controlPoint = CGPoint(x: (node1Positon.x + 40), y: node1Positon.y - 10)
        
        let endPoint = CGPoint(x: (node2Frame.origin.x + 50), y: (node2Center.y + 20))
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 120), y: (endPoint.y - 20))
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
}
