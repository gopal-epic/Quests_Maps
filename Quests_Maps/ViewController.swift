//
//  ViewController.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushQuestMapMasterViewController()
    }
    
    func pushQuestMapMasterViewController() {
        let storyboard = UIStoryboard(name: "Quest_Map_Scene", bundle: Bundle.main)
        guard let questMapMasterVC = storyboard.instantiateViewController(withIdentifier: "QuestMapMasterViewController") as? QuestMapMasterViewController,
              let navigationController = self.navigationController
              else { return }
        
        navigationController.pushViewController(questMapMasterVC, animated: true)
    }
}




