//
//  ReviewWordTableViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/18/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ReviewWordTableViewController: UITableViewController, UITraitEnvironment {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewWordController.shared.loadFromPersistentStore()
        UIView.trait
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewWordController.shared.wordsToReview.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewWordCell", for: indexPath)
        let reviewWord = ReviewWordController.shared.wordsToReview[indexPath.row]
        cell.textLabel?.text = reviewWord
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            let scoreToDelete = ReviewWordController.shared.wordsToReview[indexPath.row]
            ReviewWordController.shared.delete(wordToReview: scoreToDelete)
        }
    }

}

