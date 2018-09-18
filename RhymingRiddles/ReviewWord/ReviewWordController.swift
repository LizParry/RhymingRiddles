//
//  ReviewWord.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/12/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation
import CoreData


class ReviewWordController {
    
    static let shared = ReviewWordController()
    var wordsToReview: [String] = []
    
    init() {
        _ = fileURL
    }
    
    func save(questionWord: String) {
        wordsToReview.append(questionWord)
        saveToPersistentStore()
    }
    
    func delete(wordToReview: String) {
        guard let indexOfWordToReview = wordsToReview.index(of: wordToReview) else {return}
        wordsToReview.remove(at: indexOfWordToReview)
        saveToPersistentStore()
    }
    
    //MARK: Persistence
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let wordsToReviewLocation = "wordsToReview.json"
        let url = documentDirectory.appendingPathComponent(wordsToReviewLocation)
        print(url.absoluteString)
        return url
    }
    func saveToPersistentStore() {
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(wordsToReview)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let wordsFromDecoder = try jsonDecoder.decode([String].self, from: data)
            wordsToReview = wordsFromDecoder
        } catch let error {
            print("There was an error loading from the persistent store: \(error.localizedDescription)")
        }
        
    }
}
class ReviewWord {
    var reviewWord: String
    init(reviewWord: String) {
        self.reviewWord = reviewWord
    }
}

//
//import CoreData
//
//
//class ReviewWordController {
//
//    static let shared = ReviewWordController()
//    var wordsToReview: [String] = []
//    var newWordToReview: [ReviewWord] = []
//
//    static func change() {
//        let wordsToReview = self.wordsToReview
//        for word in wordsToReview {
//            let reviewWord = word
//            let newReviewWord = ReviewWord(reviewWord: reviewWord)
//            self.newWordToReview = [newReviewWord]
//
//        }
//        saveToPersistentStore()
//    }
//    static func delete(reviewWord: ReviewWord) {
//        reviewWord.managedObjectContext?.delete(reviewWord)
//        saveToPersistentStore()
//    }
//
//    private static func saveToPersistentStore() {
//        if CoreDataStack.context.hasChanges {
//            try? CoreDataStack.context.save()
//        }
//    }
//}
//
//
//extension ReviewWord {
//    convenience init(reviewWord: String, correctAnswer: String, incorrectAnswer: String, context: NSManagedObjectContext = CoreDataStack.context) {
//        self.init(context: context)
//        self.reviewWord = reviewWord
//        self.correctAnswer = correctAnswer
//        self.incorrectAnswer = incorrectAnswer
//
//
//    }
//
//}
