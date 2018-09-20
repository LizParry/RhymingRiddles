//
//  Word+Convenience.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
// 

import Foundation
import CoreData

// Outside of Managed Object Context
struct ResultsDictionary: Decodable {
    let results: [LexicalEntriesDictionary]
}

struct LexicalEntriesDictionary: Decodable {
    let lexicalEntries: [EntriesDictionary]
}

struct EntriesDictionary: Decodable {
    let entries: [SensesDictionary]
}

struct SensesDictionary: Decodable {
    let senses: [InfoDictionary]
}

struct InfoDictionary: Decodable {
    let definitions: [String]
}

