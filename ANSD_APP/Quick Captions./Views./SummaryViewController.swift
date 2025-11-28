//
//  SummaryViewController.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesCardCellDelegate, SummaryCardDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - 1. State Variables
    // Holds the title so it doesn't disappear when scrolling
    var conversationTitle = "Conversation 1"
    
    // Data Source for Participants
    var participantsData: [ParticipantData] = [
        ParticipantData(
            initials: "SP",
            summary: "Speaker 1 is a cab driver who inquired about whether he should drop Steve at the gate or under a particular building."
        ),
        ParticipantData(
            initials: "SP",
            summary: "Steve mentioned that the gate would be fine and gave the access code 1322 5669 and mentioned the building as C4."
        )
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Visual Setup
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        // CRITICAL: Auto-sizing row heights
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // Dismiss keyboard when tapping background
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
        print("Share functionality triggered")
    }

    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6 // Headers + Cards for (Conversation, Participants, Notes)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Section 3 is the Dynamic Participants List
        if section == 3 {
            return participantsData.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        // --- SECTION 1: CONVERSATION ---
        case 0: // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Conversation Summary"
            cell.headerIcon.image = UIImage(systemName: "list.bullet.clipboard")
            return cell
            
        case 1: // Card (Editable)
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardCell", for: indexPath) as! SummaryCardCell
            
            // FIX: Set the text from our variable so it's not empty
            cell.titleTextField.text = conversationTitle
            
            // Connect Delegate
            cell.delegate = self
            return cell
            
        // --- SECTION 2: PARTICIPANTS ---
        case 2: // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsSummaryHeaderCell", for: indexPath) as! ParticipantsSummaryHeaderCell
            return cell
            
        case 3: // Card (Dynamic)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsCardCell", for: indexPath) as! ParticipantCardCell
            let data = participantsData[indexPath.row]
            cell.configure(with: data)
            return cell
            
        // --- SECTION 3: NOTES ---
        case 4: // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Notes"
            cell.headerIcon.image = UIImage(systemName: "note.text")
            return cell
            
        case 5: // Card (Interactive)
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCardCell", for: indexPath) as! NotesCardCell
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - NotesCardCellDelegate (Auto-Resize)
    func didUpdateText(in cell: NotesCardCell) {
        // Forces the table to recalculate height without closing keyboard
        tableView.performBatchUpdates(nil, completion: nil)
        
        // Keep cursor visible
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    // MARK: - SummaryCardDelegate (Name Change Logic)
    func didChangeName(text: String) {
        // 1. Update local variable
        conversationTitle = text
        
        // 2. Update Data Logic (Example: Update Participant 1's summary)
        guard !participantsData.isEmpty else { return }
        
        var firstPerson = participantsData[0]
        let nameToDisplay = text.isEmpty ? "Speaker 1" : text
        
        firstPerson.summary = "\(nameToDisplay) is a cab driver who inquired about whether he should drop Steve at the gate..."
        
        participantsData[0] = firstPerson
        
        // 3. Reload Participant Row smoothly
        let indexPath = IndexPath(row: 0, section: 3)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
