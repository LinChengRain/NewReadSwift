//
//  MovieMoreModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieMoreModel: BaseModel {

     //MARK: - 属性定义
    var showname:String?
    var data:[MovieMoreDataModel]?
    
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
        return ["data":MovieMoreDataModel.self]
    }
}

class MovieMoreDataModel: BaseModel {
    var name:String?
    var link :String?
    
    
}
