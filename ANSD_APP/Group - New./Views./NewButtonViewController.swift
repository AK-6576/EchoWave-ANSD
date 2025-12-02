//
//  NewButtonViewController.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 01/12/25.
//

import UIKit

class NewButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func newConversationTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Group-New.", bundle: nil)
        
        // FIX: Use the correct ID "ParticipantSelectionViewController"
        if let selectionVC = storyboard.instantiateViewController(withIdentifier: "ParticipantSelectionViewController") as? ParticipantSelectionViewController {
            
            // PUSH to get the "< Back" button
            self.navigationController?.pushViewController(selectionVC, animated: true)
        }
    }
}
