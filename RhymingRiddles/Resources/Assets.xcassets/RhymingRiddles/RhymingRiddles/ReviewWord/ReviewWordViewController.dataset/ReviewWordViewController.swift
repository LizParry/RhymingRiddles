//
//  ReviewWordViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/12/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ReviewWordViewController: UIViewController {
    @IBAction func homeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewWordController.shared.loadFromPersistentStore()
        getWords()
    }
    var correctAnswer: Word?
    var incorrectAnswer: Word?
    var questionWord: String?
    
    @IBOutlet weak var starButtonOutlet: UIButton!
    @IBOutlet weak var buttonTwoOutlet: UIButton!
    @IBOutlet weak var buttonOneOutlet: UIButton!
    @IBOutlet weak var questionWordLabel: UILabel!
    @IBAction func buttonTwoTapped(_ sender: Any) {
        if buttonTwoOutlet.titleLabel?.text == correctAnswer?.word {
            correctAnswerAlert()
        } else {
            incorrectAnswerAlert()
        }
    }
    @IBAction func starButton(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "toSplitScreen", sender: self)
    }
    @IBAction func buttonOneTapped(_ sender: Any) {
        if buttonOneOutlet.titleLabel?.text == correctAnswer?.word {
            correctAnswerAlert()
        } else {
            incorrectAnswerAlert()
        }
    }
    @IBAction func removeFromReviewTapped(_ sender: Any) {
        //let index = ReviewWordController.shared.wordsToReview.index(of: questionWord!)
        //ReviewWordController.shared.wordsToReview.remove(at: index!)
        ReviewWordController.shared.delete(wordToReview: questionWord!)
        let alert = UIAlertController(title: "This word removed from your Words to Review list.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.getWords()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
    func nextWord(completion: @escaping (String?, Word?, Word?) -> Void) {
        let questionWord = ReviewWordController.shared.wordsToReview[Int(arc4random_uniform(UInt32(ReviewWordController.shared.wordsToReview.count)))]
        
        WordController.getCorrectAnswer(questionWord: questionWord) { (correctAnswer) in
            WordController.getIncorrectAnswers(questionWord: questionWord, completion: { (incorrectAnswer) in
                guard let correctAnswer = correctAnswer,
                    let incorrectAnswer = incorrectAnswer
                    else { completion(nil, nil, nil) ; return }
                completion(questionWord, correctAnswer, incorrectAnswer)
            })
        }
    }
    
    func getWords() {
        nextWord { (questionWord, correctAnswer, incorrectAnswer) in
        
            guard let questionWord = questionWord,
                let correctAnswer = correctAnswer,
                let incorrectAnswer = incorrectAnswer
                else { return }
            
            self.correctAnswer = correctAnswer
            self.incorrectAnswer = incorrectAnswer
            self.questionWord = questionWord
            
            DispatchQueue.main.async {
                self.updateViews(with: questionWord, and: correctAnswer, and: incorrectAnswer)
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
           
        }
    }
    func incorrectAnswerAlert() {
        
        let alert = UIAlertController(title: "Uh Oh! That's incorrect.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Keep trying.", style: .default) { (action) in
            self.getWords()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
    func correctAnswerAlert() {
        let alert = UIAlertController(title: "That's correct.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Keep up the good work.", style: .default) { (action) in
            self.getWords()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
}
