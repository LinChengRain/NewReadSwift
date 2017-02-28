//
//  MovieTypeModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieTypeModel: BaseModel {

    var showname:String?
    var data:[MovieTypeDataModel]?
   
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
        return ["data":MovieTypeDataModel.self]
    }
}


class MovieTypeDataModel:BaseModel {
    var name:String?
    var link:String?
}
