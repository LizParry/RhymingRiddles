//
//  GameDifficultyViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/13/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class GameDifficultyViewController: UIViewController {
    var levelNumber: String?
    override func viewWillAppear(_ animated: Bool) {
    }
    @IBAction func difficultyTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            WordController.gameWordsArray = Tests.shared.testOne
            ScoreController.shared.levelNumber = "Level 1"
        case 2:
            WordController.gameWordsArray = Tests.shared.testTwo
            ScoreController.shared.levelNumber = "Level 2"
        case 3:
            WordController.gameWordsArray = Tests.shared.testThree
            ScoreController.shared.levelNumber = "Level 3"
        case 4:
            WordController.gameWordsArray = Tests.shared.testFour
            ScoreController.shared.levelNumber = "Level 4"

        case 5:
            WordController.gameWordsArray = Tests.shared.testFive
            ScoreController.shared.levelNumber = "Level 5"

        case 6:
            WordController.gameWordsArray = Tests.shared.testSix
            ScoreController.shared.levelNumber = "Level 6"

        case 7:
            WordController.gameWordsArray = Tests.shared.testSeven
            ScoreController.shared.levelNumber = "Level 7"

        case 8:
            WordController.gameWordsArray = Tests.shared.testEight
            ScoreController.shared.levelNumber = "Level 8"

        default:
            WordController.gameWordsArray = Tests.shared.testEight
            ScoreController.shared.levelNumber = "Level 8"

        }
        UIView.animate(withDuration: 0.15, delay: 0, options: [.autoreverse], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (success) in
            if success {
                UIView.animate(withDuration: 2, animations: {
                    
                    self.performSegue(withIdentifier: "toGame", sender: self)
                }, completion: nil)
            }
            sender.transform = .identity
        }
    }
    
    
    @IBOutlet weak var levelOne: UIButton!
    @IBOutlet weak var levelTwo: UIButton!
    @IBOutlet weak var levelThree: UIButton!
    @IBOutlet weak var levelFour: UIButton!
    @IBOutlet weak var levelFive: UIButton!
    @IBOutlet weak var levelSix: UIButton!
    @IBOutlet weak var levelSeven: UIButton!
    @IBOutlet weak var levelEight: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
