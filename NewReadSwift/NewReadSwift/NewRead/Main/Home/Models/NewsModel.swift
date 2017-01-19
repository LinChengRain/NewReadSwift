//
//  NewsModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/14.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class NewsModel: BaseModel {
    
    var uniquekey:String? //请求key
    var title:String? //新闻标题
    var date:String? //日期
    var author_name:String? //新闻作者
    var url:String? //新闻详情
    var thumbnail_pic_s:String? //插图
    var thumbnail_pic_s02:String?
    var thumbnail_pic_s03:String?
}
