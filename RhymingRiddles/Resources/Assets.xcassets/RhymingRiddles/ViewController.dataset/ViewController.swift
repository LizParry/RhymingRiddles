//
//  ViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/13/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    //if review words array is empty, alert
    override func viewDidLoad() {
        super.viewDidLoad()
        Tests.shared.combineTests()
        print(Tests.shared.tests)
        print(WordController.gameWordsArray)
    }
    override func viewWillAppear(_ animated: Bool) {
        buttoneOne.transform = .identity
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var buttoneOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        GameController.shared.points = 0
        UIView.animate(withDuration: 0.15, delay: 0, options: [.autoreverse], animations: {
            self.buttoneOne.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            self.performSegue(withIdentifier: "playGame", sender: self)
            //self.buttoneOne.transform = .identity
        }
    }
    
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.autoreverse], animations: {
            self.buttonTwo.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            self.buttonTwo.transform = .identity
            if ReviewWordController.shared.wordsToReview.count == 0 {
                self.reviewAlert()
            }

            self.performSegue(withIdentifier: "reviewCards", sender: self)
        }
    }
    @IBAction func scoreButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.autoreverse], animations: {
            self.scoreButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            self.performSegue(withIdentifier: "toScores", sender: self)
            self.scoreButton.transform = .identity
        }
    }
    func reviewAlert() {
        let alert = UIAlertController(title: "UH OH! You haven't added any words yet.", message: "Click the star during the game to add words.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
}

//
//UIView.animate(withDuration: 0.2, delay: 0, options: [.autoreverse], animations: {
//    self.buttonTwo.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
//    self.buttonTwo.transform = .identity
//
//})


//self.buttoneOne.transform = CGAffineTransform(scaleX: 0, y: 0)
//
//UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
//    self.buttoneOne.transform = .identity
//}) { (_) in
//    self.performSegue(withIdentifier: "playGame", sender: self)
//}
