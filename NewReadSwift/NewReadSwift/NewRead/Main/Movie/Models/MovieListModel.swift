//
//  MovieListModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

///电影资讯数据模型
class MovieListModel: BaseModel {

    var name:String?
    var link:String?
    var data:[MovieDetailModel]?
    
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
       return ["data":MovieDetailModel.self]  //传入对应类型
    }
    
}


