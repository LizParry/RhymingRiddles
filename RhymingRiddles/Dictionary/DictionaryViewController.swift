//
//  DictionaryViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    var dictionaryTerm: String?
    
    @IBOutlet weak var searchBarTerm: UISearchBar!
    @IBOutlet weak var searchTermDefinition: UITextView!
    
    @IBOutlet weak var dictionaryTermTextView: UITextView!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarTerm.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        removePartialCurlTap()
    }
    
    private func removePartialCurlTap() {
        if let gestures = self.view.gestureRecognizers {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }
    
}
//if let gestures = self.view.gestureRecognizers as? [UIGestureRecognizer] {


extension DictionaryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBarTerm.text, !searchTerm.isEmpty else {return}
        
        DictionaryTermController.fetchWord(wordID: searchTerm) { (definition) in
            
            DispatchQueue.main.async {
                self.dictionaryTermTextView.text = definition
                if !(definition != nil) {
                    self.dictionaryTermTextView.text = "Sorry. You're on your own. There's no definition available for this word."
                }
            }
        }
    }
}
