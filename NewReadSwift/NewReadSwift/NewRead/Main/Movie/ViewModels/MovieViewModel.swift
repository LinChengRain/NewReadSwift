//
//  MovieViewModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {

    
    /// 数据请求处理
    ///
    /// - Parameters:
    ///   - dtype: 返回数据的格式,xml或json，默认json
    ///   - city: 	城市名称
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
    func sendMovieNews(dtype:String?,city:String,success:@escaping(_ result:[MovieListModel])->(),failure:@escaping( _ error:Any)->Void) -> Void {
        
        ///参数
        //转码
//        let newCityStr =  city.addingPercentEncoding(withAllowedCharacters: CharacterSet.newlines)
        //"dtype":dtype,
        let params = ["key":MovieAppKey,"city":city]
        
        LCNetworkServerManager.shareInstance.request(url: PMovie_Base_Url, method: .POST, params: params as Dictionary<String, AnyObject>?, success: { (data) in
            
            if let response = (try?JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Dictionary<String, Any>){
             
                let error_code:Int = response["error_code"] as! Int
                let reason = response["reason"] as? String
                if error_code == 0{
                
                    print(reason!)
                    let dic:Dictionary<String,Any> = (response["result"] as? Dictionary)!
                    let dataArray:Array<Any>?
                    dataArray = (dic["data"] as? Array)!
                    //数据处理
                  let data = self.dataAnalysis(result: dataArray as! Array<Dictionary<String, Any>>)
                    
                    success(data)
                }else{
                  
                    print(reason!)
                }
            }else{
            
            }
        }) { (error) in
            
            failure(error!)
        }
    }
    
    //MARK: - data analysis
    
    /// 数据解析
    ///
    /// - Parameter result: 传入的数据
    /// - Returns: 返回处理好的模型
    private func dataAnalysis(result:Array<Dictionary<String, Any>>)->Array<MovieListModel>{
        ///数据存储
        var dataArray:[MovieListModel] = []
        
        for dic:Dictionary in result {
            let model:MovieListModel = MovieListModel.init(dic:dic)
            ///存入数据源
            dataArray.append(model)
        }
        return dataArray;
    }
}
