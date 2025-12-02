//
//  ParticipantSelectionViewController.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 02/12/25.
//

import UIKit

class ParticipantSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let contacts = [
        "Steve Rogers", "Bucky Barnes", "Tony Stark",
        "Natasha Romanoff", "Bruce Banner", "Peter Parker",
        "Wanda Maximoff", "Vision"
    ]
    var selectedIndices: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.title = "Select Participants"
        
        // --- THIS LISTENS FOR THE SIGNAL FROM SUMMARY SCREEN ---
        NotificationCenter.default.addObserver(self, selector: #selector(goHome), name: NSNotification.Name("ReturnToHome"), object: nil)
    }
    
    // --- THIS EXECUTES WHEN SUMMARY SAYS "END SESSION" ---
    @objc func goHome() {
        // Pop this screen off the stack, returning you to the NewButtonViewController
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChat" {
            if let chatVC = segue.destination as? GroupNewViewController {
                chatVC.modalPresentationStyle = .fullScreen
            }
        }
    }

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return contacts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndices.contains(indexPath.row) { selectedIndices.remove(indexPath.row) }
        else { selectedIndices.insert(indexPath.row) }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
