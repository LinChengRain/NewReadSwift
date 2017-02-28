//
//  MovieDetailModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieDetailModel: BaseModel {
    
    var tvTitle:String?
    var iconaddress:String?
    var iconlinkUrl:String?
    var m_iconlinkUrl:String?
    var subHead:String?
    var grade:NSNumber?   //成绩
    var gradeNum:String?      //成绩
    var playDate:MoviePlayDateModel?  //发布时间
    var director:MovieDirectorModel? //导演
    var star:MovieStarModel?    //评级
    var type:MovieTypeModel?    //类型
    var story:MovieStarModel?   //剧情
    var more:MovieMoreModel?   //更多
    
    override func lc_modelPropertyClass() -> [String : AnyClass]? {
        return ["playDate":MoviePlayDateModel.self,"director":MovieDirectorModel.self,"star":MovieStarModel.self,"type":MovieTypeModel.self,"story":MovieStarModel.self,"more":MovieMoreModel.self]  //传入对应类型
    }
    
}
