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
    
    struct Padding {
        let nodeType: NodeType
        var x: CGFloat {
            return (self.nodeType == .finish ? 440.0 : 264.0)
        }
    }
    
    struct Origin {
        let isFirstNode: Bool
        let order: Order
        let previousXValue: CGFloat
        let padding: Padding
        
        var x: CGFloat {
            var xValue: CGFloat
            
            if self.isFirstNode == true {
                xValue = QuestObjectiveModel.kDefaultXForiPAD
            } else {
                xValue = previousXValue + padding.x
            }
            
            return xValue
        }
        
        var y: CGFloat {
            return ((self.order == .even) ? 95.0 : -20.0)
        }
    }
    
    struct Size {
        let nodeType: NodeType
        
        var width: CGFloat {
            return (self.nodeType == .finish ? 112.0 : 400)
        }
        
        var height: CGFloat {
            return (self.nodeType == .finish ? 112.0 : 403)
        }
    }
    
    struct Position {
        let value: Int
        let origin: Origin
        let size: Size
    }
    
    static let kDefaultXForiPAD: CGFloat = -84.0
    
    let index: Int
    let count: Int
    let withReadingBuddy: Bool
    let order: Order
    let nodeType: NodeType
    let state: State
    let position: Position
    let isFirstNode: Bool
    let isLastNode: Bool
    
    // MARK: - Init Methods
    
    init(currentIndex: Int, objectivesCount: Int, withBuddy: Bool, objectiveState: State, currentXValue: CGFloat) {
        index = currentIndex
        count = objectivesCount
        withReadingBuddy = withBuddy
        state = objectiveState
        isFirstNode = (currentIndex == 0)
        isLastNode = (currentIndex == (objectivesCount - 1))
        order = (((currentIndex % 2) == 0) ? .even : .odd)
        nodeType = (isLastNode ? .finish : (withReadingBuddy ? .questObjectiveWithBuddy : .questObjective))
        position = Position(value: (currentIndex + 1), origin: Origin(isFirstNode: (currentIndex == 0), order: order, previousXValue: currentXValue, padding: Padding(nodeType: nodeType)), size: Size(nodeType: nodeType))
    }
}
