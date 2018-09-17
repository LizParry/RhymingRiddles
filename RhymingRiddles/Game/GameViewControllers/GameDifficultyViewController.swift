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

        switch sender {
        case levelOne :
            WordController.gameWordsArray = Tests.shared.testOne
        case levelTwo :
            WordController.gameWordsArray = Tests.shared.testTwo
        case levelThree :
            WordController.gameWordsArray = Tests.shared.testThree
        case levelFour :
            WordController.gameWordsArray = Tests.shared.testFour
        case levelFive :
            WordController.gameWordsArray = Tests.shared.testFive
        case levelSix :
            WordController.gameWordsArray = Tests.shared.testSix
        case levelSeven :
            WordController.gameWordsArray = Tests.shared.testSeven
        case levelEight :
            WordController.gameWordsArray = Tests.shared.testEight
        default:
            WordController.gameWordsArray = Tests.shared.testEight
        }
        performSegue(withIdentifier: "toGame", sender: self)
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
