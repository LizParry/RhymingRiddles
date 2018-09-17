//
//  DictionaryViewController.swift
//  RhymingRiddles
//
//  Created by Liz Parry on 9/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {


    @IBOutlet weak var searchTermDefinition: UITextView!
    @IBOutlet weak var dictionarySearchTerm: UISearchBar!
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        removePartialCurlTap()
    }

    private func removePartialCurlTap() {
        if let gestures = self.view.gestureRecognizers as? [UIGestureRecognizer] {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }

}
