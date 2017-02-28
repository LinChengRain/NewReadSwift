//
//  MovieStoryModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieStoryModel: BaseModel {

    var showname:String?
    var data:MovieStoryDataModel?
    
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
        return ["data":MovieStoryDataModel.self]
    }
}

class MovieStoryDataModel: BaseModel {
    
    var storyBrief:String?
    var storyMoreLink:String?
    
    
}
