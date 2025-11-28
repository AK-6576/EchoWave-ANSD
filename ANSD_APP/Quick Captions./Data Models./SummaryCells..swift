//
//  SummaryCells.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

// MARK: - Protocol for Auto-Resizing Notes
protocol NotesCardCellDelegate: AnyObject {
    func didUpdateText(in cell: NotesCardCell)
}

// MARK: - Helper for Card Styling
private func styleCard(view: UIView?) {
    guard let card = view else { return }
    card.layer.cornerRadius = 12
    card.backgroundColor = .white
    // Shadow matching Figma soft look
    card.layer.shadowColor = UIColor.black.cgColor
    card.layer.shadowOpacity = 0.05
    card.layer.shadowOffset = CGSize(width: 0, height: 2)
    card.layer.shadowRadius = 4
}

// MARK: - 1. Section Header Cell
// Use this for "Conversation Summary" and "Notes"
class SummarySectionHeaderCell: UITableViewCell {
    @IBOutlet weak var headerIcon: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
}

// MARK: - 2. Conversation Card Cell
class SummaryCardCell: UITableViewCell {
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
    }
}

// MARK: - 3. Participants Header Cell
class ParticipantsSummaryHeaderCell: UITableViewCell {
    @IBOutlet weak var participantIcon: UIImageView! // Optional, if you have an icon
    @IBOutlet weak var participantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
}

// MARK: - 4. Participant Detail Card (Dynamic)
class ParticipantCardCell: UITableViewCell {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView! // Changed from UIView to UIImageView
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
        
        // Style the Avatar Image
        avatarImageView.layer.cornerRadius = 4 // Rounded square like Figma
        avatarImageView.clipsToBounds = true
        avatarImageView.tintColor = .systemGray // Makes the SF Symbol grey
    }
    
    func configure(with data: ParticipantData) {
        // We only set the summary text now
        detailsLabel.text = data.summary
    }
}

// MARK: - 5. Notes Input Card (Real-time Typing)
class NotesCardCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    
    weak var delegate: NotesCardCellDelegate?
    let placeholderText = "Add your notes about this conversation..."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
        
        // Setup Text View
        notesTextView.delegate = self
        notesTextView.text = placeholderText
        notesTextView.textColor = .lightGray
        notesTextView.font = UIFont.systemFont(ofSize: 15)
        
        // CRITICAL: This allows the cell to grow.
        notesTextView.isScrollEnabled = false
        notesTextView.textContainerInset = .zero
        notesTextView.textContainer.lineFragmentPadding = 0
    }
    
    // MARK: - Placeholder Logic
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = UIColor.label // Black in light mode
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    // MARK: - Resize Logic
    func textViewDidChange(_ textView: UITextView) {
        // Tell the Controller to resize the table row
        delegate?.didUpdateText(in: self)
    }
}
