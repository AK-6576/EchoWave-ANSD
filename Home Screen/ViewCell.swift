//
// ViewCell.swift
// Group_4-ANSD_App
//
// Created by Daiwiik on 26/11/25.
//

import UIKit
import Foundation

// Define the data model for the vertical list of past conversations
struct ConversationHistoryItem: Codable, Identifiable {
    let id: String
    let title: String          // e.g., "Daily Check-In", "Conversation 1"
    let description: String    // e.g., "Discussed Serum X's medical applications...."
    let date: String           // e.g., "Oct 5, 2025"
    let timeRange: String      // e.g., "11:30 - 12:30 PM"
    let tag: String?           // e.g., "Office" or "Quick Captioning" (Optional)
    let tagIconName: String?   // SFSymbol name for the tag icon
}
class ViewCell: UICollectionViewCell {

    // MARK: Outlets
    
    // The main container view for the card styling (rounded corners, shadow, white background)
    @IBOutlet weak var containerView: UIView!
    
    // Top-most large title (e.g., "Daily Check-In")
    @IBOutlet weak var titleLabel: UILabel!
    
    // Subtitle for conversation context (e.g., "Discussed Serum X's medical applications....")
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Date icon and text
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // Time icon and text
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    // The tag/category section (e.g., "Office" or "Quick Captioning")
    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    // Navigation arrow on the right
    @IBOutlet weak var arrowImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply card styling
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        
        // Optional: Add a subtle shadow for a better card look
        // Note: You may need to disable clipsToBounds on the main cell contentView for shadow to work.
        // self.layer.shadowColor = UIColor.black.cgColor
        // self.layer.shadowOpacity = 0.1
        // self.layer.shadowOffset = CGSize(width: 0, height: 2)
        // self.layer.shadowRadius = 4
        
        // Set up fixed icons
        dateIcon.image = UIImage(systemName: "calendar")
        timeIcon.image = UIImage(systemName: "clock")
        arrowImage.image = UIImage(systemName: "chevron.right")
        arrowImage.tintColor = .systemGray4
        
        // Ensure the cell background is clear so the CollectionView's background shows
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    // MARK: Configuration Method
    
    func configure(with item: ConversationHistoryItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        dateLabel.text = item.date
        timeLabel.text = item.timeRange
        
        // Handle the optional tag area (Office or Quick Captioning)
        if let tagText = item.tag, let iconName = item.tagIconName {
            tagLabel.text = tagText
            tagIcon.image = UIImage(systemName: iconName)
            
            // Make them visible
            tagLabel.isHidden = false
            tagIcon.isHidden = false
        } else {
            // Hide the tag elements if no tag is provided
            tagLabel.isHidden = true
            tagIcon.isHidden = true
        }
    }
}
