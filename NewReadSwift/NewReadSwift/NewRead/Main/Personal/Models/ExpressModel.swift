//
//  ExpressModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class ExpressModel: BaseModel {

    var company:String? //快递公司
    var com:String? //小写
    var no:String? //快递单号
    var status:String? /* 1表示此快递单的物流信息不会发生变化，此时您可缓存下来；0表示有变化的可能性 */
    var list:Array<ExpressListModel>?
}

class ExpressListModel: BaseModel {
    var datetime:String? // "2016-06-15 21:44:04",  /* 物流事件发生的时间 */
     var remark:String? // "离开郴州市 发往长沙市【郴州市】", /* 物流事件的描述 */
     var region:String? /* 快件当时所在区域，由于快递公司升级，现大多数快递不提供此信息 */
    
    override func attributesDic(dic: [String : Any]) -> [String : String] {
        
        var newDic:[String:String] = [:]
        
        for key in dic.keys {
            //复写时注意将属性名作为key 数据字典的key作为value
            newDic[region!] = key
        }
        
        return newDic
    }
}

  
