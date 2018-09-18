//
//  GameViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: Outlets and Properties
    var correctAnswer: Word?
    var incorrectAnswer: Word?
    var questionWord: String?
    var originalPosition: CGPoint! //cant subclass value types
    var questionCount = 0

    @IBOutlet weak var wallet: UIImageView!
    @IBOutlet weak var patrolImage: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var questionWordLabel: UILabel!
    @IBOutlet weak var buttonOneOutlet: UIButton!
    @IBOutlet weak var buttonTwoOutlet: UIButton!

    //MARK: IBActions

    @IBAction func addToReviewTapped(_ sender: Any) {
        ReviewWordController.shared.save(questionWord: questionWord!)
        let alert = UIAlertController(title: "This word was added to your Words to Review list.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    @IBAction func buttonOneTapped(_ sender: Any) {
        if buttonOneOutlet.titleLabel?.text == correctAnswer?.word {
            GameController.shared.points += 10
            questionCount += 1
            print("\(questionCount)")
            print("Correct word chosen! \(GameController.shared.points)")
            correctAnswerAlert()
        } else {
            GameController.shared.points -= 10
            questionCount += 1
            print("Incorrect answer chosen \(GameController.shared.points)")
            print("\(questionCount)")
            incorrectAnswerAlert()
        }
    }
    
    @IBAction func buttonTwoTapped(_ sender: Any) {
        if buttonTwoOutlet.titleLabel?.text == correctAnswer?.word {
            GameController.shared.points += 10
            questionCount += 1
            print("\(questionCount)")
            print("Correct word chosen \(GameController.shared.points)")
            correctAnswerAlert()
        } else {
            GameController.shared.points -= 10
            questionCount += 1
            print("\(questionCount)")
            print("Incorrect answer chosen \(GameController.shared.points)")
            incorrectAnswerAlert()
        }
    }
    
    @IBAction func close(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)

    }
   
    //MARK: Word Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        getWords()
    }
    
    func getWords() {
        GameController.shared.nextWord { (questionWord, correctAnswer, incorrectAnswer) in
            guard let questionWord = questionWord,
                let correctAnswer = correctAnswer,
                let incorrectAnswer = incorrectAnswer
                else { return }
            self.questionWord = questionWord
            self.correctAnswer = correctAnswer
            self.incorrectAnswer = incorrectAnswer
            
            DispatchQueue.main.async {
                    self.updateViews(with: questionWord, and: correctAnswer, and: incorrectAnswer)
                    if self.questionCount == 20 {
                        self.wonGame()
                    
                } 
            }
        }
    }
    func updateViews(with questionWord: String, and correctAnswer: Word, and incorrectAnswer: Word) {
        
        var buttons = [self.buttonTwoOutlet, self.buttonOneOutlet]
        let answerButton1 = buttons[Int(arc4random_uniform(UInt32(buttons.count)))]
        guard let label1Index = buttons.index(of: answerButton1) else { return }
        buttons.remove(at: label1Index)
        let answerButton2 = buttons[0]
        DispatchQueue.main.async {
            self.questionWordLabel.text = questionWord + "?"
            answerButton1!.setTitle(correctAnswer.word, for: .normal)
            answerButton2?.setTitle(incorrectAnswer.word, for: .normal)
            self.pointsLabel.text = "$ \(GameController.shared.points)"
        }
    }
    
    //MARK: Alerts
    func wonGame() {
        let alert = UIAlertController(title: "You Won!", message: "Your score is \(GameController.shared.points)!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let saveScore = UIAlertAction(title: "Save Score", style: .default) { (_) in
            ScoreController.shared.addScore(score: GameController.shared.points)
        }
        alert.addAction(saveScore)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        GameController.shared.points = 0
        return
    }
    
    func incorrectAnswerAlert() {
        let alert = UIAlertController(title: "Uh Oh! You owe the Pronunciation Patrol $10.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Better luck next time.", style: .default) { (action) in
            self.getWords()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        animatePatrol()
        return
    }
    
    func correctAnswerAlert() {
        let alert = UIAlertController(title: "You earned $10.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Keep up the good work.", style: .default) { (action) in
                       self.getWords()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        animateMoney()
        return
    }
    
    //MARK: Animations
    @objc func animatePatrol() {
        self.patrolImage.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.transitionCurlUp], animations: {
            self.patrolImage.transform = .identity
        }, completion: nil)
    }
    
    @objc func animateMoney() {
        self.wallet.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.transitionCurlUp], animations: {
            self.wallet.transform = .identity
        }, completion: nil)
    }
}





//WordController.shared.mockGame[Int(arc4random_uniform(UInt32(WordController.shared.mockGame.count - 1)))]
