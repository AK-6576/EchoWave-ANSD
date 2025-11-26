//
//  RoutineCollectionViewCell.swift
//  Group_4-ANSD_App
//
//  Created by Daiwiik on 26/11/25.
//

import UIKit

class RoutineCell: UICollectionViewCell {

    
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    
    @IBOutlet weak var topicLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    // This function populates the cell with the data model
        func configure(with conversation: RoutineConversation) {
            
            // 1. Set text labels
            categoryLabel.text = conversation.categoryTitle
            statusLabel.text = conversation.status
            topicLabel.text = conversation.conversationTopic
            timeLabel.text = conversation.timeRange
            
            // 2. Set SFSymbols for icons
            // Assuming iconName holds an SFSymbol name.
            if let image = UIImage(systemName: conversation.iconName) {
                categoryImage.image = image
            } else {
                // Handle case where SFSymbol might not be found (use a placeholder)
                categoryImage.image = UIImage(systemName: "questionmark.circle.fill")
            }
            
            // Set up the arrow (optional styling)
            arrowImage.image = UIImage(systemName: "chevron.right")
            arrowImage.tintColor = .systemGray
            
            // You can add logic here to change colors based on conversation category or status
            // e.g., if conversation.categoryTitle == "Office" { categoryImage.tintColor = .systemBlue }
        }
}
