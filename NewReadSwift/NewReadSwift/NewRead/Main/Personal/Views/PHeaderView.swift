//
//  PHeaderView.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class PHeaderView: UIView {

//    private let headerImageView:UIImageView? = nil
   
    override init(frame: CGRect) {
        super.init(frame: frame)

        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 加载子视图
    private func loadSubviews(){
    
        self.addSubview(headerImageView)
       
    }
    
    private lazy var headerImageView:UIImageView = {
    
        let imageView:UIImageView = UIImageView.init(frame: CGRect(x:0,y:0,width:80,height:80))
        imageView.center = self.center
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.yellow
        
        return imageView
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
