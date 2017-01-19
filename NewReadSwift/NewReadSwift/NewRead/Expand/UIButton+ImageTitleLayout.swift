//
//  UIButton+ImageTitleLayout.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/19.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

///图片和文字相对位置
///top:image在上，label在下
///left:image在左，label在右
///bottom:image在下，label在上
///right:image在右，label在左
enum MYButtonEdgeInsetsStyle {
    case top
    case left
    case bottom
    case right
}
extension UIButton{
  
    func layoutButton(style:MYButtonEdgeInsetsStyle,space:CGFloat) -> Void {
        
        /// 1. 得到imageView和titleLabel的宽、高
        let imageWidth = imageView?.frame.size.width
        let imageHeight = imageView?.frame.size.height
        
        var labelWidth:CGFloat = 0.0
        var labelHeight:CGFloat = 0.0
        
        if UIDevice.current.systemVersion >= "8.0" {
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else{
            labelWidth = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
        /// 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageViewEdgeInsets:UIEdgeInsets = .zero
        var labelEdgeInsets:UIEdgeInsets = .zero
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            imageViewEdgeInsets = UIEdgeInsetsMake(-labelHeight - space/2.0, 0, 0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth!, (-imageHeight!) - space/2.0, 0)
            break
        case .bottom:
            imageViewEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake((-imageHeight!)-space/2.0, -imageWidth!, 0, 0)
            
            break
        case .left:
            imageViewEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0)
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0)
            
            break
        case .right:
            imageViewEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsetsMake(0, (-imageWidth!)-space/2.0, 0, imageWidth!+space/2.0)
            break
        }
        
        /// 4. 赋值
        titleEdgeInsets = labelEdgeInsets
        imageEdgeInsets = imageViewEdgeInsets  
    }


}
