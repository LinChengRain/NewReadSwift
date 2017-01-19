//
//  NewsViewCell.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/14.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    @IBOutlet weak var author: UILabel!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var thumbnail_pic_s: UIImageView!
    
    @IBOutlet weak var thumbnail_pic_s02: UIImageView!
    
    @IBOutlet weak var thumbnail_pic_s03: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
