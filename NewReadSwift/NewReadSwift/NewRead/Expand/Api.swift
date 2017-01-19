//
//  Api.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class Api: NSObject {

    
}

//MARK: - 应用接口
///请求示例：http://v.juhe.cn/toutiao/index?type=top&key=APPKEY
let News_Base_Url = "http://v.juhe.cn/toutiao/index"
let Exp_Base_Url = "http://v.juhe.cn/exp/index"
let Express_Base_Url = "https://m.kuaidi100.com/index_all.html"


/// 根据RGBA生成颜色(格式为：22,22,22,0.5)
func RGBColor(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat) -> UIColor {
    return UIColor(red: (red) / 255.0, green: (green) / 255.0, blue: (blue) / 255.0, alpha: 1.0);
}

func CGRectMake(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) -> CGRect {
    return CGRect(x:x,y:y,width:width,height:height)
}
//20, 155, 213


//MARK: - 常量
let NewsAppKey = "1db74f2bee7789d6527a4db98d2a680e"
let ExpAppKey = "b353745235c76911e3eba630e329b24f"

let K_Screen_Height = UIScreen.main.bounds.size.height
let K_Screen_Width = UIScreen.main.bounds.size.width
let K_TabBar_Height = 49
let K_NavigationBar_Height = 64



