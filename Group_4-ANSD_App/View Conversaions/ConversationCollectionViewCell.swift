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
   
}
