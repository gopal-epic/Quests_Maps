//
//  QuestPath.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestPath: CAShapeLayer {
    
    enum PathType {
        case dottedLine
        case thickLine
    }
    
    // MARK: - Vars and Constants
    
    static var kDefaultStrokeColor: CGColor { return UIColor.white.cgColor }
    static var kDefaultFillColor: CGColor { return UIColor.clear.cgColor }
    static var kDefaultLineWidth: CGFloat { return 8.0 }
    static var kDefaultLineDashPattern: [NSNumber] { return [8,18] }
    
    var pathType: PathType = .dottedLine
    
    var strokeColorValue: CGColor = kDefaultStrokeColor
    
    var fillColorValue: CGColor = kDefaultFillColor
    
    var lineWidthValue: CGFloat = kDefaultLineWidth
    
    var lineDashPatternValue: [NSNumber]? {
        switch pathType {
        case .dottedLine:
            return QuestPath.kDefaultLineDashPattern
        default:
            return nil
        }
    }
    
    // MARK: - Init Methods
    
    init(path: CGPath, pathType: PathType) {
        self.pathType = pathType
        
        super.init()
        
        self.path = path
        self.strokeColor = strokeColorValue
        self.fillColor = fillColorValue
        self.lineWidth = lineWidthValue
        self.lineDashPattern = lineDashPatternValue
        self.lineCap = CAShapeLayerLineCap.round
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
