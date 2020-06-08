//
//  QuestMapAlgorithm.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestMapAlgorithm: NSObject {
    
    class func determineBeizerPath(from node1View: QuestObjectiveView, node2View: QuestObjectiveView) -> UIBezierPath {
        let node1Frame = node1View.frameInQuestMap
        let node1Positon = CGPoint(x: (node1Frame.origin.x + node1Frame.size.width - 4), y: (node1View.centerInQuestMap.y + 30))
        
        let controlPoint = CGPoint(x: (node1Positon.x + 60), y: node1Positon.y)
        
        let node2Frame = node2View.frameInQuestMap
        let endPoint = CGPoint(x: (node2Frame.origin.x + 15), y: node2View.centerInQuestMap.y + 40)
        
        let controlPointTwo = CGPoint(x: (endPoint.x - 60), y: ((endPoint.y + 40)))
        
        let path = UIBezierPath()
        path.flatness = 0.05
        path.move(to: node1Positon)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPointTwo)
        
        return path
    }
}
