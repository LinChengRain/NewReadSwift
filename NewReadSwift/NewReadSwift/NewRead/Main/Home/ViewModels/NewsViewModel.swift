//
//  NewsViewModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class NewsViewModel: NSObject {

    func newsData(refreshData:Bool,success:@escaping([NewsModel])->(),failure:@escaping( _ error:Any)->Void)->Void {
    
//        var dataArray:[NewsModel] = []
        if refreshData == false {
            print("无新数据")
            return;
        }
        let params = ["key":NewsAppKey,"type":"top"]
        
        LCNetworkServerManager.shareInstance.request(url: News_Base_Url, method: .POST, params: params as Dictionary, success: { (data) in
            
            if let result = try?JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
            {
                
                let error_code:NSNumber = result["error_code"] as! NSNumber;
                if  error_code == 0{
                
                    print(result["result"]!);
                    let data:Dictionary<String,Any> = result.value(forKey: "result") as! Dictionary
                    
                    let arr:Array<Dictionary<String, Any>> = data["data"]! as! Array<Dictionary<String, Any>>
                 
                    let array = self.dataAnalysis(result: arr)
                    
                    success(array)
                }else{
                
                    print(result["reason"]!)
                    
                    failure(result["reason"]!)
                }
            }else{
            
                 print("解析失败")
            }
        }) { (error) in
            
            print(error!)
            failure(error!)
        }
        
    }
    
    //MARK: - data analysis
    private func dataAnalysis(result:Array<Dictionary<String, Any>>)->Array<NewsModel>{
     
        var dataArray:[NewsModel] = []
        for dic in result {
            
            let model:NewsModel =  NewsModel(dic:dic)
            
//            let model:NewsModel = NewsModel.in
            dataArray.append(model)
        }

    
        return dataArray
    }
}
