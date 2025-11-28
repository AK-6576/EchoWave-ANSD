//
//  ConversationCollectionViewCell.swift
//  Group_4-ANSD_App
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class ConversationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var descriptionLabel: UILabel!
      @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var categoryLabel: UILabel!
      @IBOutlet weak var calendarIcon: UIImageView!
      @IBOutlet weak var clockIcon: UIImageView!
      @IBOutlet weak var categoryIcon: UIImageView!
       
    
    override func awakeFromNib() {
            super.awakeFromNib()

            containerView.layer.cornerRadius = 20
            containerView.layer.masksToBounds = false
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.08
            containerView.layer.shadowRadius = 6
            containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        }
    func configure(with conversation: Conversation) {
            
            // 1. Set the primary text fields
            self.titleLabel.text = conversation.title
            self.descriptionLabel.text = conversation.description
            
            // 2. Automate the Category Label
            let categoryString = conversation.category
            
            // Capitalize the first letter (e.g., "office" -> "Office")
            let capitalizedCategory = categoryString.prefix(1).uppercased() + categoryString.dropFirst()
            
            self.categoryLabel.text = capitalizedCategory
            
            // Note: You can also automate the category icon here if needed
            // self.categoryIcon.image = UIImage(named: conversation.icon)
            
            // Set Date and Time (example)
            self.dateLabel.text = conversation.date
        self.timeLabel.text = "\(conversation.startTime) - \(conversation.startTime)"
        }
   
}
