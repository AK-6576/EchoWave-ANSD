//
//  MonthHeader.swift
//  Group_4-ANSD_App
//
//  Created by SDC-USER on 27/11/25.
//

import Foundation
// MonthHeaderView.swift
import UIKit

class MonthHeaderView: UICollectionReusableView {
    
    // **CRITICAL:** This outlet must be connected in the XIB.
    @IBOutlet weak var monthLabel: UILabel!
    
    // This is optional but useful for setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Example styling:
        monthLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        monthLabel.textColor = .darkGray
    }
    
    // Optional configuration function (for robustness)
    func configure(with title: String) {
        monthLabel.text = title
    }
}
