//
//  CountDownTableViewCell.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class CountDownTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var backWaveView: UIView!
    @IBOutlet weak var waveView: UIView!
    @IBOutlet weak var waveImage: UIImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var leftDaysLabel: UILabel!
    @IBOutlet weak var borrowNameLabel: UILabel!
    @IBOutlet weak var tillDeadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
