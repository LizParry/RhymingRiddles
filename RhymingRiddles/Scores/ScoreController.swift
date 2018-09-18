//
//  Score.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/18/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation
class ScoreController: Codable {
    static var shared = ScoreController()
    var scores = [Score]()
    
    func addScore(score: Int) {
        let newScore = Score(score: score)
        scores.append(newScore)
        saveToPersistentStore()
    }
    func deleteScore(score: Score) {
        guard let index = scores.index(of: score) else {return}
        scores.remove(at: index)
        saveToPersistentStore()
    }
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let scores = "scores.json"
        let url = documentDirectory.appendingPathComponent(scores)
        print(url.absoluteString)
        return url
    }
    func saveToPersistentStore() {
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(scores)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let scoresFromDecoder = try jsonDecoder.decode([Score].self, from: data)
            scores = scoresFromDecoder
        } catch let error {
            print("There was an error loading from the persistent store: \(error.localizedDescription)")
        }
    }
}

class Score: Equatable, Codable {
    var score: Int
    var timestamp = Date()
    init(score: Int) {
        self.score = score
    }
    static func == (lhs: Score, rhs: Score) -> Bool {
        return(lhs.score == rhs.score && lhs.timestamp == rhs.timestamp)
    }
}
