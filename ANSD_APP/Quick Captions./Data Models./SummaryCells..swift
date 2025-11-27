//
//  SummaryCells.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

// MARK: - 1. Section Header Cell (Reusable)
// Used for "Conversation Summary" and "Notes" headers
class SummarySectionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerIcon: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // No specific styling needed here
    }
}

// MARK: - 2. Conversation Summary Card
class SummaryCardCell: UITableViewCell {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel! // Ensure this is connected in Storyboard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCard(view: mainCardView)
    }
}

// 1. Define this protocol outside the class
protocol NotesCardCellDelegate: AnyObject {
    func didUpdateText(in cell: NotesCardCell)
}

class NotesCardCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    // 2. Add a delegate property
    weak var delegate: NotesCardCellDelegate?
    
    let placeholderText = "Add your notes about this conversation..."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCard(view: mainCardView)
        
        notesTextView.delegate = self
        notesTextView.text = placeholderText
        notesTextView.textColor = .lightGray
        notesTextView.font = UIFont.systemFont(ofSize: 15)
        
        // 3. CRITICAL: Disable scrolling so the text view expands instead of scrolling internally
        notesTextView.isScrollEnabled = false
    }
    
    // MARK: - UITextView Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    // 4. This function fires every time a character is typed
    func textViewDidChange(_ textView: UITextView) {
        // Notify the view controller to update layout
        delegate?.didUpdateText(in: self)
    }
}

// MARK: - 4. Participants Header Cell
class ParticipantsSummaryHeaderCell: UITableViewCell {
    
    @IBOutlet weak var participantIcon: UIImageView!
    @IBOutlet weak var participantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - 5. Participant Detail Cell (Dynamic)
class ParticipantCardCell: UITableViewCell {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var avatarCircle: UIView!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCard(view: mainCardView)
        
        // Make the avatar circle perfectly round
        avatarCircle.layer.cornerRadius = avatarCircle.frame.height / 2
        avatarCircle.clipsToBounds = true
    }
    
    // Helper function to populate data
    func configure(with data: ParticipantData) {
        detailsLabel.text = data.summary
    }
}

// MARK: - Global Helper Function
// Defines the shadow and corner radius style for all cards
private func styleCard(view: UIView?) {
    guard let card = view else { return }
    
    card.layer.cornerRadius = 12
    card.backgroundColor = .white // or .systemBackground if supporting dark mode fully
    
    // Shadow properties
    card.layer.shadowColor = UIColor.black.cgColor
    card.layer.shadowOpacity = 0.05
    card.layer.shadowOffset = CGSize(width: 0, height: 2)
    card.layer.shadowRadius = 4
}

