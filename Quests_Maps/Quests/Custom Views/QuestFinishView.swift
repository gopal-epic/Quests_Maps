//
//  QuestFinishView.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/8/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestFinishView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var starInactiveImageView: UIImageView!
    @IBOutlet weak var starActiveLottieView: UIView!
    
    static var tabbedNibName: String { return "QuestFinishView" }
    
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
        Bundle.main.loadNibNamed(QuestFinishView.tabbedNibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

