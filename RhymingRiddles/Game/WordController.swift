//
//  WordController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/11/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation

class Word: Decodable {
    let word: String
    var isCorrect: Bool?
}

class WordController: Decodable {
    static var gameWordsArray: [String] = []
        //Tests.shared.tests[Int(arc4random_uniform(UInt32(Tests.shared.tests.count)))]
    
    static func getCorrectAnswer(questionWord: String, completion: @escaping (Word?) -> Void) {
        
        let baseURL = URL(string: "https://api.datamuse.com/words")
        guard let url = baseURL else {completion(nil); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let wordqueryItem = URLQueryItem(name: "rel_rhy", value: questionWord)
        
        components?.queryItems = [wordqueryItem]
        
        guard let dataTaskRequest = components?.url else {completion(nil); return}
        URLSession.shared.dataTask(with: dataTaskRequest) { (data, _, error) in
            
            if let error = error {
                print("There was an error retrieving data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            do {
                let correctAnswers = try JSONDecoder().decode([Word].self, from: data)
                let correctAnswer = correctAnswers[0]
                correctAnswer.isCorrect = true
                //self.correctAnswer = [correctAnswers[Int(arc4random_uniform(UInt32(3)))]]
                //make index random except first dont allow first index
                completion(correctAnswer)
            } catch {
                print("There was an error decoding the JSON: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        .resume()
    }
  
    static func getIncorrectAnswers(questionWord: String, completion: @escaping (Word?) -> Void) {
        
        let baseURL = URL(string: "https://api.datamuse.com/words")
        guard let url = baseURL else {completion(nil); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let wordqueryItem = URLQueryItem(name: "sl", value: questionWord)
        
        components?.queryItems = [wordqueryItem]
        
        guard let dataTaskRequest = components?.url else {completion(nil); return}
        URLSession.shared.dataTask(with: dataTaskRequest) { (data, _, error) in
            
            if let error = error {
                print("There was an error retrieving data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            do {
                let incorrectAnswers = try JSONDecoder().decode([Word].self, from: data)
               
                let incorrectAnswer = incorrectAnswers[2]
                incorrectAnswer.isCorrect = false
                completion(incorrectAnswer)
            } catch {
                print("There was an error decoding the JSON: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        .resume()
        
    }
}
