//
//  SummaryViewController.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesCardCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - 1. Data Source (Using the Struct)
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
        
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        // Auto Layout for dynamic cell heights
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // Tap to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        print("Share functionality")
    }

    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Section 3 is the Participants List -> Uses array count
        if section == 3 {
            return participantsData.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        // --- CONVERSATION SUMMARY ---
        case 0: // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Conversation Summary"
            cell.headerIcon.image = UIImage(systemName: "list.bullet.clipboard")
            return cell
            
        case 1: // Card
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardCell", for: indexPath) as! SummaryCardCell
            cell.titleLabel.text = "Conversation 1"
            return cell
            
        // --- PARTICIPANTS SUMMARY ---
        case 2: // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsSummaryHeaderCell", for: indexPath) as! ParticipantsSummaryHeaderCell

            cell.participantLabel.text = "Participants Summary"
            return cell
            
        case 3: // Dynamic Cards
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsCardCell", for: indexPath) as! ParticipantCardCell
            let data = participantsData[indexPath.row]
            cell.configure(with: data)
            return cell
            
        // --- NOTES ---
        case 4: // Header
            // Reusing the generic header but changing text/icon
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Notes"
            cell.headerIcon.image = UIImage(systemName: "note.text")
            return cell
            
        case 5: // Interactive Card
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCardCell", for: indexPath) as! NotesCardCell
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - NotesCardCellDelegate
    // This keeps the keyboard open and animates the cell growing
    func didUpdateText(in cell: NotesCardCell) {
        tableView.performBatchUpdates(nil, completion: nil)
        
        // Scroll slightly to keep cursor visible
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}
