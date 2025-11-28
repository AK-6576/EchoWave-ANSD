//
//  SummaryCells.swift
//  Quick Captioning
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

// MARK: - Protocols
protocol NotesCardCellDelegate: AnyObject {
    func didUpdateText(in cell: NotesCardCell)
}

// 1. New Protocol: Tells the controller when the title changes
protocol SummaryCardDelegate: AnyObject {
    func didChangeName(text: String)
}

// MARK: - Styling Helper
private func styleCard(view: UIView?) {
    guard let card = view else { return }
    card.layer.cornerRadius = 12
    card.backgroundColor = .white
    card.layer.shadowColor = UIColor.black.cgColor
    card.layer.shadowOpacity = 0.05
    card.layer.shadowOffset = CGSize(width: 0, height: 2)
    card.layer.shadowRadius = 4
}

// MARK: - Header Cells
class SummarySectionHeaderCell: UITableViewCell {
    @IBOutlet weak var headerIcon: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
}

class ParticipantsSummaryHeaderCell: UITableViewCell {
    @IBOutlet weak var participantIcon: UIImageView!
    @IBOutlet weak var participantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
}

// MARK: - 1. Conversation Card (Editable)
class SummaryCardCell: UITableViewCell {
    
    @IBOutlet weak var mainCardView: UIView!
  
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    weak var delegate: SummaryCardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
    }
    
    // LINK THIS ACTION: Right-click Text Field -> Drag "Editing Changed" here
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        delegate?.didChangeName(text: sender.text ?? "")
    }
}

// MARK: - 2. Participant Detail Card
class ParticipantCardCell: UITableViewCell {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
        
        avatarImageView.layer.cornerRadius = 4
        avatarImageView.clipsToBounds = true
        avatarImageView.tintColor = .systemGray
    }
    
    func configure(with data: ParticipantData) {
        detailsLabel.text = data.summary
    }
}

// MARK: - 3. Notes Input Card
class NotesCardCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    
    weak var delegate: NotesCardCellDelegate?
    let placeholderText = "Add your notes about this conversation..."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        styleCard(view: mainCardView)
        
        notesTextView.delegate = self
        notesTextView.text = placeholderText
        notesTextView.textColor = .lightGray
        notesTextView.font = UIFont.systemFont(ofSize: 15)
        notesTextView.isScrollEnabled = false
        notesTextView.textContainerInset = .zero
        notesTextView.textContainer.lineFragmentPadding = 0
    }
    
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
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.didUpdateText(in: self)
    }
}
