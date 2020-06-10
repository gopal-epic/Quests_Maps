//
//  QuestObjectiveModel.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/9/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

struct QuestObjectiveModel {
    
    // MARK: - Var & Constants
    
    enum Order: Int {
        case even
        case odd
    }
    
    enum NodeType {
        case questObjective
        case questObjectiveWithBuddy
        case finish
    }
    
    enum State: Int {
        case notStarted = 0
        case completed = 1
        case inProgress = 2
        case closed = 3
    }
    
    static let kDefaultXForiPAD: CGFloat = -84.0
    
    let index: Int
    let count: Int
    let withReadingBuddy: Bool
    let order: Order
    let nodeType: NodeType
    let state: State
    let isFirstNode: Bool
    let isLastNode: Bool
    
    let previousXValue: CGFloat
    
    var paddingForXValue: CGFloat {
        return (nodeType == .finish ? 440.0 : 264.0)
    }
    var origin: CGPoint {
        var x: CGFloat {
            var xValue: CGFloat
            
            if self.isFirstNode == true {
                xValue = QuestObjectiveModel.kDefaultXForiPAD
            } else {
                xValue = previousXValue + paddingForXValue
            }
            
            return xValue
        }
        
        var y: CGFloat {
            return (nodeType == .finish ? 112.0 : ((self.order == .even) ? 95.0 : -20.0))
        }
        
        return CGPoint(x: x, y: y)
    }
    var size: CGSize {
        var width: CGFloat {
            return (nodeType == .finish ? 112.0 : 400)
        }
        
        var height: CGFloat {
            return (nodeType == .finish ? 112.0 : 403)
        }
        
        return CGSize(width: width, height: height)
    }
    var position: CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    // MARK: - Init Methods
    
    init(currentIndex: Int, objectivesCount: Int, withBuddy: Bool, objectiveState: State, previousXVal: CGFloat) {
        index = currentIndex
        count = objectivesCount
        withReadingBuddy = withBuddy
        state = objectiveState
        isFirstNode = (currentIndex == 0)
        isLastNode = (currentIndex == (objectivesCount - 1))
        order = (((currentIndex % 2) == 0) ? .even : .odd)
        nodeType = (isLastNode ? .finish : (withReadingBuddy ? .questObjectiveWithBuddy : .questObjective))
        
        previousXValue = previousXVal
    }
}
