//
//  GameController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/12/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class GameController {
    
    static let shared = GameController()
    var questionCount = 0
    var points = 50
    //var isCorrect: Bool?
    
    func nextWord(completion: @escaping (String?, Word?, Word?) -> Void) {
        let questionWord = WordController.gameWordsArray[Int(arc4random_uniform(UInt32(WordController.gameWordsArray.count)))] //***
        
        WordController.getCorrectAnswer(questionWord: questionWord) { (correctAnswer) in
            WordController.getIncorrectAnswers(questionWord: questionWord, completion: { (incorrectAnswer) in
                guard let correctAnswer = correctAnswer,
                    let incorrectAnswer = incorrectAnswer
                    else { completion(nil, nil, nil) ; return }
                completion(questionWord, correctAnswer, incorrectAnswer)
            })
        }
    }
    
}
