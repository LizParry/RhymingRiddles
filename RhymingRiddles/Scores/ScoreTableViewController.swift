//
//  ScoreTableViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/18/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ScoreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreController.shared.loadFromPersistentStore()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreController.shared.scores.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        let score = ScoreController.shared.scores[indexPath.row]
        cell.textLabel?.text = "\(score.levelNumber)     Score: $ \(score.score)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        //cell.textLabel?.textColor = UIColor.
        
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: score.timestamp))"
        return cell
    }

   
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let scoreToDelete = ScoreController.shared.scores[indexPath.row]
            ScoreController.shared.deleteScore(score: scoreToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
