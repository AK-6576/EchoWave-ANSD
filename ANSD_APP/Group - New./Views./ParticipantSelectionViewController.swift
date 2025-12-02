//
//  ParticipantSelectionViewController.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 02/12/25.
//

import UIKit

class ParticipantSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    let contacts = [
        "Steve Rogers", "Bucky Barnes", "Tony Stark",
        "Natasha Romanoff", "Bruce Banner", "Peter Parker",
        "Wanda Maximoff", "Vision"
    ]
    
    // Tracks which rows are selected
    var selectedIndices: Set<Int> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Setup Table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() // Remove empty lines
    }

    // MARK: - Navigation (The Segue)
    
    // This function runs automatically because you connected the button in Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToChat" {
            if let chatVC = segue.destination as? GroupNewViewController {
                
                // OPTIONAL: Pass the selected name to the chat
                // For example, if you want the chat to be named after the first selection:
                /*
                if let firstIndex = selectedIndices.first {
                    chatVC.otherPersonName = contacts[firstIndex]
                }
                */
                
                // Ensure Chat opens Full Screen
                chatVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    // Note: We do NOT need code inside @IBAction func tickTapped
    // because the Storyboard Segue handles the click automatically.

    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        // Checkmark Logic
        if selectedIndices.contains(indexPath.row) {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .systemBlue
        } else {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .label
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndices.contains(indexPath.row) {
            selectedIndices.remove(indexPath.row)
        } else {
            selectedIndices.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
