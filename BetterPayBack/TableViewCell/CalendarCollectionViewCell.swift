//
//  CalendarCollectionViewCell.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/30.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var calendarLabel: UILabel!
    
    @IBOutlet weak var redDot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        calendarLabel.textColor = .black
        redDot.isHidden = true
        redDot.frame = CGRect(x: frame.width * 0.5 - 5, y: frame.height * 0.1, width: 10, height: 10)
        
    }
}
