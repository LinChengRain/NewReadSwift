//
//  UIView+Extension.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

extension UIView{

    //MARK: -  Origin
    /// x
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set(newVal){
            var tmpFrame: CGRect = frame
            tmpFrame.origin.x = newVal
            frame = tmpFrame
        }
    }
    /// y
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set(newVal){
            var tmpFrame:CGRect = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    /// bottom
    var bootom:CGFloat{
        get{
            return y + height
        }
        set(newVal) {
            y = newVal - height
        }
    }
    /// top
    var top:CGFloat{
        get{
            return origin.y
        }
        set(newVal){
            y = newVal
        }
    }
    /// centerX
    var centerX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    /// centerY
    var centerY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }

    /// origin
    private var origin:CGPoint{
        get{
            return frame.origin
        }
    }
    
    
    //MARK: -  Size
    /// width
    var width:CGFloat{
        get{
            return frame.size.width
        }
        set(newVal){
            var tmpFrame:CGRect = frame
            tmpFrame.size.width = newVal
            frame = tmpFrame
        }
    }
    
    /// height
    var height:CGFloat{
        get{
            return frame.size.height
        }
        set(newVal){
            var tmpFrame:CGRect = frame
            tmpFrame.size.height = newVal
            frame = tmpFrame
        }
    }
    
    /// size
    private var size:CGSize{
        get{
            return frame.size
        }
    }
}
