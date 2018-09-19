//
//  ReviewWordTableViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/18/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class ReviewWordTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var reviewWord: String?
    var definition: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewWordController.shared.loadFromPersistentStore()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    @IBOutlet weak var tableView: UITableView!
    
    func getDefinition() {
        DictionaryTermController.fetchWord(wordID: reviewWord!, completion: { (definition) in
            self.definition = definition
            DispatchQueue.main.async {
                
                if !(definition != nil) {
                    self.definition = "Sorry. You're on your own. There's no definition available for this word."
                }
            }
        })
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewWordController.shared.wordsToReview.count
    }
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewWordCell", for: indexPath)
        let reviewWord = ReviewWordController.shared.wordsToReview[indexPath.row]
        
        DictionaryTermController.fetchWord(wordID: reviewWord) { (definition) in
            
            DispatchQueue.main.async {
                guard let definition = definition else {return}
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "\(reviewWord): " + definition
                if !(definition != nil) {
                    cell.textLabel?.text = definition + ": Sorry. You're on your own. There's no definition available for this word."
                }
            }
        }
        self.reviewWord = reviewWord
        return cell
    }
    
    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let scoreToDelete = ReviewWordController.shared.wordsToReview[indexPath.row]
//            ReviewWordController.shared.delete(wordToReview: scoreToDelete)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

