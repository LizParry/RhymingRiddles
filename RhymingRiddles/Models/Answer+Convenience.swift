//
//  Answer+Convenience.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/7/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation
import CoreData

extension Answer {
    convenience init(answer: String, isCorrect: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.answer = answer
        self.isCorrect = isCorrect
    }
}
