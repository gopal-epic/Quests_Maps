//
//  QuestMapMasterViewController.swift
//  Quests_Maps
//
//  Created by Gopal Rao Gurram on 6/4/20.
//  Copyright © 2020 Gopal Rao Gurram. All rights reserved.
//

import UIKit

class QuestMapMasterViewController: UIViewController {
    
    private var questMapViewController: QuestMapViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if let mapViewController = destination as? QuestMapViewController {
            questMapViewController = mapViewController
            mapViewController.delegate = self
        }
    }
}

extension QuestMapMasterViewController: QuestObjectivesDelegate {
    func didSelectQuestObjective(with id: String) {
        print("Show books Popup UI for this id: ",id)
    }
}
