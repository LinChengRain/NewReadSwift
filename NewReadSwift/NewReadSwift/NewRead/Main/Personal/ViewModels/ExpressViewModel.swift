//
//  ExpressViewModel.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class ExpressViewModel: NSObject {

    func send(com:String,
               no:String,
          success:@escaping(_ result:Dictionary<String, Any>)->Void,
          failure:@escaping (_ error:Any)->Void) -> Void {
        
        let params = ["key":ExpAppKey,"com":com,"no":no]
        LCNetworkServerManager.shareInstance.postServer(url: Exp_Base_Url, params: params as Dictionary, success: { (data) in
          
            if let dataJson = try?JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Dictionary<String, Any>{
                
                print(dataJson)

                if dataJson["error_code"] == nil && dataJson["resultcode"] as! String == "200"{
                    let resultDic:Dictionary<String,AnyObject> = dataJson["result"] as! Dictionary;
                    let array:Array<Dictionary<String, Any>> = resultDic["list"] as! Array<Dictionary<String, Any>>
                    
                    //最终数据源
                    var dataDict:Dictionary<String,Any>?
                    ///快递详情数据
                    var dataArray:Array<Any>?
                    for dic in array{
                        let expressListModel:ExpressListModel = ExpressListModel.init(dic:dic)
                        //存入数组
                        dataArray?.append(expressListModel)
                    }
                    dataDict?["list"] = dataArray
                    
                    ///填充到字典
                    let expressModel:ExpressModel = ExpressModel.init(dic:resultDic)
                    dataDict?["result"] = expressModel
                    
                    success(dataDict!)
                }else{
                    failure(dataJson["reason"]!)
                }
            }else{
                print("解析失败")
                failure("解析失败")
            }
        }) { (error) in
            
            if let error = error{
                print(error)
              failure(error)
            }
        }
        
    }
}
