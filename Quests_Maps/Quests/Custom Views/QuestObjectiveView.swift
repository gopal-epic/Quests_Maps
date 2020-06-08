//
//  QuestObjectiveView.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/5/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestObjectiveView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var starBustLottieView: UIView!
    @IBOutlet weak var starBustImageView: UIImageView!
    
    @IBOutlet weak var nodeBaseView: UIView!
    @IBOutlet weak var nodeBaseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveEclipseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveNumberLabel: UILabel!
    
    @IBOutlet weak var nodeActiveMarkerOrBuddyView: UIView!
    @IBOutlet weak var nodeActiveMarkerImageView: UIImageView!
    
    static var tabbedNibName: String { return "QuestObjectiveView" }
       
    var frameInQuestMap: CGRect {
        let contentViewFrame = self.frame
        let nodeBaseViewFrame = nodeBaseView.frame
        
        return CGRect.init(x: (contentViewFrame.origin.x + nodeBaseViewFrame.origin.x), y: (contentViewFrame.origin.y + nodeBaseViewFrame.origin.y), width: nodeBaseViewFrame.size.width, height: nodeBaseViewFrame.size.height)
    }
    
    var centerInQuestMap: CGPoint {
        return CGPoint.init(x: (frameInQuestMap.origin.x + (frameInQuestMap.size.width / 2)), y: (frameInQuestMap.origin.y + (frameInQuestMap.size.height / 2)))
    }
    
    // MARK:- Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(QuestObjectiveView.tabbedNibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
