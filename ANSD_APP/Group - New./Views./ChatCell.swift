//
//  ChatCell.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 25/11/25.
//

import UIKit

class OutgoingCell: UICollectionViewCell {
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            bubbleView.layer.cornerRadius = 16
            bubbleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
            
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        }
    }

class IncomingCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var onLabelTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.backgroundColor = .systemGray5
        messageLabel.textColor = .black
        
        bubbleView.layer.cornerRadius = 16
        bubbleView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        
        nameLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        nameLabel.addGestureRecognizer(tap)
        
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
    }
    @objc func handleTap() { onLabelTapped?() }
}
