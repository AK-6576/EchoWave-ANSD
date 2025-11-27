//
//  SummaryViewController.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesCardCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - 1. Data Source (Structs)
    
    // This array holds the dynamic data for your Participants section
    var participantsData: [ParticipantData] = [
        ParticipantData(
            initials: "SP",
            summary: "Speaker 1 is a cab driver who inquired about whether he should drop Steve at the gate or under a particular building."
        ),
        ParticipantData(
            initials: "SP",
            summary: "Steve mentioned that the gate would be fine and gave the access code 1322 5669 and mentioned the building as C4. He paid 124 Bucks for his ride, ending his journey."
        )
    ]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Basic Setup
        view.backgroundColor = .systemGroupedBackground
        
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        // CRITICAL: Enable Auto Layout for row heights
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // Dismiss keyboard when tapping outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        print("Share tapped - functionality to export notes can go here")
    }

    // MARK: - Table Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6 // Headers + Cards for Conversation, Notes, and Participants
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            // Section 5 is the Participants List -> Return count of our data array
            return participantsData.count
        }
        // All other sections (Headers and Single Cards) have 1 row
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            // 1. HEADER: Conversation
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Conversation Summary"
            cell.headerIcon.image = UIImage(systemName: "list.bullet.clipboard")
            return cell
            
        case 1:
            // 2. CARD: Conversation Details
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardCell", for: indexPath) as! SummaryCardCell
            cell.titleLabel.text = "Conversation 1"
            // You can set date/location here if you have outlets for them
            return cell
            
        case 2:
            // 3. HEADER: Notes
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Notes"
            cell.headerIcon.image = UIImage(systemName: "note.text")
            return cell
            
        case 3:
            // 4. CARD: Interactive Notes
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCardCell", for: indexPath) as! NotesCardCell
            cell.titleLabel.text = "Notes"
            // Set the delegate so the cell can tell us when to resize
            cell.delegate = self
            return cell
            
        case 4:
            // 5. HEADER: Participants
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsHeaderCell", for: indexPath) as! ParticipantsSummaryHeaderCell
            return cell
            
        case 5:
            // 6. CARD: Participant Details (Dynamic List)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantDetailCell", for: indexPath) as! ParticipantCardCell
            
            // Get data for this specific row
            let data = participantsData[indexPath.row]
            
            // Configure the cell (updates the Initials and Summary Label)
            cell.configure(with: data)
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - NotesCardCellDelegate
    
    // This is called whenever you type in the Notes cell
    func didUpdateText(in cell: NotesCardCell) {
        // Forces the table view to recalculate cell heights without reloading data (keeps keyboard open)
        tableView.performBatchUpdates(nil, completion: nil)
        
        // Optional: Scroll to keep the cursor visible if it goes off screen
        // if let indexPath = tableView.indexPath(for: cell) {
        //    tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        // }
    }
}
