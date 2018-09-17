//
//  WordController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//
// apiID 7b22aaa6
//64bc4b923cde406e75c6908a17c7691a
// https://od-api.oxforddictionaries.com/api/v1  base url

import Foundation
class DictionaryTermController {
    
    let shared = DictionaryTermController()
    static func fetchWord(with wordID: String, completion: @escaping ((String?) -> Void)) {
        let appId = "7b22aaa6"
        let appKey = "64bc4b923cde406e75c6908a17c7691a"
        let language = "en"
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(wordID.lowercased())")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, _, error in
            if let data = data
            {
                do {
                    let resultsDictionary = try JSONDecoder().decode(ResultsDictionary.self, from: data)
                    completion(resultsDictionary.results.first?.lexicalEntries.first?.entries.first?.senses.first?.definitions.first)
//                    print(definitions)
                } catch {
                    print(error)
                    completion(nil)
                    return
                }
            } else {
                print(error?.localizedDescription)
            }
        }).resume()
    }

}
