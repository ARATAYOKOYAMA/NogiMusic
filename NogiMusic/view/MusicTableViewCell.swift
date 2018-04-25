//
//  MusicTableViewCell.swift
//  NogiMusic
//
//  Created by 横山　新 on 2018/04/16.
//  Copyright © 2018年 横山　新. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNo: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackNo.textColor = UIColor(hex: "932993")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
