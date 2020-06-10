//
//  QuestObjectiveView.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/5/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestObjectiveView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var starBustLottieView: UIView!
    @IBOutlet weak var starBustImageView: UIImageView!
    
    @IBOutlet weak var nodeBaseView: UIView!
    @IBOutlet weak var nodeBaseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveEclipseImageView: UIImageView!
    @IBOutlet weak var nodeBaseActiveNumberLabel: UILabel!
    
    @IBOutlet weak var nodeActiveMarkerImageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!
    
    // MARK: - Var & Constants
    
    static var tabbedNibName: String { return "QuestObjectiveView" }
    fileprivate var quesObjectiveModel: QuestObjectiveModel
       
    var frameInQuestMap: CGRect {
        let contentViewFrame = self.frame
        let nodeBaseViewFrame = nodeBaseView.frame
        
        return CGRect.init(x: (contentViewFrame.origin.x + nodeBaseViewFrame.origin.x), y: (contentViewFrame.origin.y + nodeBaseViewFrame.origin.y), width: nodeBaseViewFrame.size.width, height: nodeBaseViewFrame.size.height)
    }
    
    var centerInQuestMap: CGPoint {
        return CGPoint.init(x: (frameInQuestMap.origin.x + (frameInQuestMap.size.width / 2)), y: (frameInQuestMap.origin.y + (frameInQuestMap.size.height / 2)))
    }
    
    // MARK:- Init Methods
    init(frame: CGRect, objectiveModel: QuestObjectiveModel) {
        self.quesObjectiveModel = objectiveModel
        
        super.init(frame: frame)
        commonInit()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(QuestObjectiveView.tabbedNibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func updateUI() {
        guard quesObjectiveModel.state != QuestObjectiveModel.State.notStarted else { return }
        
        starBustLottieView.isHidden = !quesObjectiveModel.showStarBustLottieView
        nodeBaseImageView.image = quesObjectiveModel.nodeBaseImage
        nodeBaseActiveEclipseImageView.isHidden = !quesObjectiveModel.showEclipseCircle
        nodeBaseActiveNumberLabel.text = quesObjectiveModel.nodeNumber
        
        nodeActiveMarkerImageView.isHidden = !quesObjectiveModel.showActiveMarkerImageView
        flagImageView.isHidden = !quesObjectiveModel.showFlagImageView
    }
}
