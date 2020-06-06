//
//  QuestObjectiveView.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/5/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestObjectiveView: UIView {

    @IBOutlet weak var starBustLottieView: UIView!
    @IBOutlet weak var starBustImageView: UIImageView!
    
    @IBOutlet weak var nodeBaseView: UIView!
    @IBOutlet weak var nodeBaseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveEclipseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveNumberLabel: UILabel!
    
    @IBOutlet weak var nodeActiveMarkerOrBuddyView: UIView!
    @IBOutlet weak var nodeActiveMarkerImageView: UIImageView!
    
    static var tabbedNibName: String { return "EpicBackPackView" }
    
    // MARK:- Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
