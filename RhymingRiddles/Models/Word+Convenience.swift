//
//  Term+Convenience.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/7/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation
import CoreData

extension Word: Decodable {
    
    convenience init(word: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.word = word
    }
}
