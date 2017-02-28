//
//  MovieStarModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieStarModel: BaseModel {

    var showname:String?
    var data:[MovieStarDataModel]?
    
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
        return ["data":MovieStarDataModel.self]
    }
}

class MovieStarDataModel: BaseModel {
    var name:String?
    var link:String?
}
