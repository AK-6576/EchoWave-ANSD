//
//  RoutineCollectionViewCell.swift
//  Group_4-ANSD_App
//
//  Created by Daiwiik on 26/11/25.
//

import UIKit

class RoutineCell: UICollectionViewCell {
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var topicImage: UIImageView!
    
    @IBOutlet weak var timeImage: UIImageView!
    

    // MARK: - Lifecycle
        
    override func awakeFromNib() {
            super.awakeFromNib()
            setupCardStyle()
            setupIconStyle()
            
            // 2. ⚠️ ADD THE SPACING CODE HERE
                    // This tells the stack: "Put 24 points of space right after the status label, but keep everything else normal."
            mainStackView.setCustomSpacing(24, after: statusLabel)
        }
        
        // MARK: - Styling Functions
        
        private func setupCardStyle() {
            // 1. Transparent Cell Background (so we can see the gaps)
            self.backgroundColor = .clear
            self.contentView.backgroundColor = .clear
            
            // 2. Card Container Styling (The White Card)
            cardContainerView.backgroundColor = .white // Or .systemBackground
            cardContainerView.layer.cornerRadius = 20
            
            // 3. Shadow Effect (Matches your Figma "Floating" look)
            cardContainerView.layer.shadowColor = UIColor.black.cgColor
            cardContainerView.layer.shadowOpacity = 0.08 // Subtle shadow
            cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
            cardContainerView.layer.shadowRadius = 8
            
            // Important: Optimizes shadow performance and ensures it shows
            cardContainerView.layer.masksToBounds = false
        }
        
        private func setupIconStyle() {
            // Style the Category Image (The Blue Box)
            categoryImage.layer.cornerRadius = 10 // Makes it rounded square
            categoryImage.clipsToBounds = true
            categoryImage.contentMode = .center // Keeps the icon centered
            
            // Default colors (will be updated in configure)
            categoryImage.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            categoryImage.tintColor = .systemBlue
        }

        // MARK: - Configuration
        
        func configure(with conversation: RoutineConversation) {
            
            // 1. Set Labels
            categoryLabel.text = conversation.categoryTitle
            statusLabel.text = conversation.status
            topicLabel.text = conversation.conversationTopic
            timeLabel.text = conversation.timeRange
            arrowImage.image = UIImage(systemName: "chevron.right")
            timeImage.image=conversation.timeRange.isEmpty ? nil : UIImage(systemName: "clock")
            topicImage.image=conversation.categoryTitle.isEmpty ? nil : UIImage(systemName: "text.bubble")
            
            
            // 2. Set Icon
            if let image = UIImage(systemName: conversation.iconName) {
                categoryImage.image = image
            } else {
                categoryImage.image = UIImage(systemName: "questionmark.circle.fill")
            }
            
            // 3. Dynamic Styling (Optional)
            // Change colors based on category
            switch conversation.categoryTitle {
            case "Office":
                setTheme(color: .systemBlue)
            case "Family":
                setTheme(color: .systemPink)
            case "Friends":
                setTheme(color: .systemGreen)
            default:
                setTheme(color: .systemGray)
            }
        }
        
        // Helper to color the icon background and text match
        private func setTheme(color: UIColor) {
            categoryImage.tintColor = color
            categoryImage.backgroundColor = color.withAlphaComponent(0.1) // Light background
        }
    }
