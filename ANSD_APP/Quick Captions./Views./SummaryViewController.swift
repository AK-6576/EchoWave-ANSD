//
//  SummaryViewController.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesCardCellDelegate, SummaryCardDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var conversationTitle = "Conversation 1"
    
    // MARK: - Data Source
    var participantsData: [ParticipantData] = [
        ParticipantData(
            name: "Bucky Barnes",
            initials: "SP",
            summary: "Bucky Barnes is a cab driver who inquired about whether he should drop Steve at the gate or under a particular building."
        ),
        ParticipantData(
            name: "Steve",
            initials: "SP",
            summary: "Steve mentioned that the gate would be fine and gave the access code 1322 5669 and mentioned the building as C4."
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
    @IBAction func backTapped(_ sender: Any) { dismiss(animated: true, completion: nil) }
    @IBAction func shareTapped(_ sender: Any) { print("Share tapped") }

    // MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int { return 6 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 { return participantsData.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Conversation Summary"
            cell.headerIcon.image = UIImage(systemName: "list.bullet.clipboard")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardCell", for: indexPath) as! SummaryCardCell
            
            // Only loading Title
            cell.titleTextField.text = conversationTitle
            
            cell.delegate = self
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsSummaryHeaderCell", for: indexPath) as! ParticipantsSummaryHeaderCell
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsCardCell", for: indexPath) as! ParticipantCardCell
            cell.configure(with: participantsData[indexPath.row])
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummarySectionHeaderCell", for: indexPath) as! SummarySectionHeaderCell
            cell.headerLabel.text = "Notes"
            cell.headerIcon.image = UIImage(systemName: "note.text")
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCardCell", for: indexPath) as! NotesCardCell
            cell.delegate = self
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    // MARK: - Delegates
    func didUpdateText(in cell: NotesCardCell) {
        tableView.performBatchUpdates(nil, completion: nil)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    func didChangeTitle(text: String) {
        conversationTitle = text
    }
}
