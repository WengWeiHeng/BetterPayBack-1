//
//  TopCalendarCollectionViewCell.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class TopCalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collecyionDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collecyionDayLabel.textColor = .darkGray
        collecyionDayLabel.layer.borderWidth = 0.5
        collecyionDayLabel.layer.shadowColor = UIColor.black.cgColor
        collecyionDayLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        collecyionDayLabel.layer.shadowOpacity = 0.1
        collecyionDayLabel.layer.shadowRadius = 1
    }
    
}
