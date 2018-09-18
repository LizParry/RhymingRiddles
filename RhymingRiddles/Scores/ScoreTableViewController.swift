//
//  ScoreTableViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/18/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreController.shared.scores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        let score = ScoreController.shared.scores[indexPath.row]
        cell.textLabel?.text = "\(score.score)"
        cell.detailTextLabel?.text = "\(score.timestamp)"
        return cell
    }

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            let scoreToDelete = ScoreController.shared.scores[indexPath.row]
            ScoreController.shared.deleteScore(score: scoreToDelete)
        }
    }
    
}
