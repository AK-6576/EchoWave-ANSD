//
//  SummaryViewController.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesCardCellDelegate, SummaryCardDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data Source
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
        
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
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
        if section == 3 { return participantsData.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        // --- 1. CONVERSATION ---
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Conversation Summary"
            cell.headerIcon.image = UIImage(systemName: "list.bullet.clipboard")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardCell", for: indexPath) as! SummaryCardCell
            // CRITICAL: Set the delegate so the cell can talk to this controller
            cell.delegate = self
            return cell
            
        // --- 2. PARTICIPANTS ---
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsSummaryHeaderCell", for: indexPath) as! ParticipantsSummaryHeaderCell
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsCardCell", for: indexPath) as! ParticipantCardCell
            let data = participantsData[indexPath.row]
            cell.configure(with: data)
            return cell
            
        // --- 3. NOTES ---
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Notes"
            cell.headerIcon.image = UIImage(systemName: "note.text")
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCardCell", for: indexPath) as! NotesCardCell
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - Logic 1: Handle Note Resizing
    func didUpdateText(in cell: NotesCardCell) {
        tableView.performBatchUpdates(nil, completion: nil)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    // MARK: - Logic 2: Handle Name Change (Real-Time)
    func didChangeName(text: String) {
        // Safety check
        guard !participantsData.isEmpty else { return }
        
        // 1. Logic: If you type "John", we update the first person's summary
        var firstPerson = participantsData[0]
        
        let name = text.isEmpty ? "Speaker 1" : text
        
        // Update the string. (This is just an example logic, you can customize the sentence)
        firstPerson.summary = "\(name) is a cab driver who inquired about whether he should drop Steve at the gate..."
        
        // 2. Save to array
        participantsData[0] = firstPerson
        
        // 3. Reload ONLY the first Participant Card to see the change instantly
        let indexPath = IndexPath(row: 0, section: 3)
        
        // Using 'none' animation prevents the keyboard from jumping/closing
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
