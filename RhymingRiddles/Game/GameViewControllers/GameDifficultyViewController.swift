//
//  GameDifficultyViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/13/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class GameDifficultyViewController: UIViewController {
    
    @IBAction func difficultyTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            print("One tapped")
            WordController.gameWordsArray = Tests.shared.testOne
        case 2:
            WordController.gameWordsArray = Tests.shared.testTwo
        case 3:
            WordController.gameWordsArray = Tests.shared.testThree
        case 4:
            WordController.gameWordsArray = Tests.shared.testFour
        case 5:
            WordController.gameWordsArray = Tests.shared.testFive
        case 6:
            WordController.gameWordsArray = Tests.shared.testSix
        case 7:
            WordController.gameWordsArray = Tests.shared.testSeven
        case 8:
            WordController.gameWordsArray = Tests.shared.testEight
        default:
            WordController.gameWordsArray = Tests.shared.testEight
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
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
