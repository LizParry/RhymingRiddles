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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var buttoneOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.autoreverse], animations: {
            self.buttoneOne.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            self.performSegue(withIdentifier: "playGame", sender: self)
            self.buttoneOne.transform = .identity
        }
    }

    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.autoreverse], animations: {
            self.buttonTwo.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            self.performSegue(withIdentifier: "reviewCards", sender: self)
            self.buttonTwo.transform = .identity
        }
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
