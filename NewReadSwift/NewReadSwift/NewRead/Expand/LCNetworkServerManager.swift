//
//  LCNetworkServerManager.swift
//  LCNetworkServer
//
//  Created by Changlin Yu on 2017/1/11.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

// Swift的枚举支持任意数据类型,不需要,分隔
enum LCHttpMethod{
    
    case GET; case POST
//    case PUT = "PUT"
//    case DELETE = "DELETE"
}

final class LCNetworkServerManager: NSObject {
    
    //MARK: - 单例
    static var shareInstance:LCNetworkServerManager{
     struct Static{
        static var instance :LCNetworkServerManager = LCNetworkServerManager()
        }
        return Static.instance
    }
    private override init(){}
    
    
    open func request(url:String,
                   method:LCHttpMethod,
                   params:Dictionary<String,AnyObject>?,
                  success:@escaping((_ result:Data?)->()),
                  failure:@escaping((_ error: Error?)->())){
        switch method {
          case .POST:
            self.postServer(url: url, params: params, success: success, failure: failure)
            break
          case .GET:
            self.getServer(url: url, params: params, success: success, failure: failure)
            break
        }
    }
    
    
    //MARK: - GET 请求
    open func getServer(url:String,
                        params:Dictionary<String,AnyObject>?,
                        success:@escaping((_ result:Data?)->()),
                        failure:@escaping((_ error: Error?)->())){
        
        //1 处理参数
        var address = url

        var paramStr = ""
        if let params = params {
            paramStr = "?" + buildParams(parameters: params as [String : AnyObject])
        }
        address.append(paramStr)
        
        
        //2 url
        let url = URL.init(string:address)
        //3 request
        var request = URLRequest.init(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        request.httpMethod = "GET"
        //4 实例化session
        let session = URLSession.shared
        //5 请求任务
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                failure(error!)
            }else{
                if (response as! HTTPURLResponse).statusCode  == 200{
                    success(data)
                }else{
//                    failure(error)
                }
            }
        }
        //6 开始任务
        dataTask.resume()
    }
    
    //MARK: - POST
    /// 发起一个POST请求，返回success或者failure的回调结果
    ///
    /// - Parameters:
    ///   - url: 目标地址
    ///   - params: 参数表
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
    open func  postServer(url:String,
                          params:Dictionary<String,AnyObject>?,
                          success: @escaping ((_ result: Data?) -> ()),
                          failure: @escaping ((_ error: Error?) -> ()))
    {
        //1 目标地址
        let url = URL.init(string: url)
        
        //2 参数
        var paramStr:String = ""
        if let params = params  {
          paramStr =  buildParams(parameters: params as [String : AnyObject])
        }
        
        
        //3 请求实例
        var request = URLRequest.init(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        ///请求方法
        request.httpMethod = "POST"
        // 请求体
        request.httpBody = paramStr.data(using: .utf8)
        
        //4
        let session = URLSession.shared
        
        //5
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                failure(error)
            }else{
                if (response as! HTTPURLResponse).statusCode == 200 {
                    success(data)
                }else{
                    failure(error)
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK: - buildParams
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sorted() {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key:key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    
    //MARK: - queryComponents
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(key:"\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents(key:"\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        
        return components
    }
    //MARK: - escape
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFString = ":&=;+!@#$()',*" as CFString
        return CFURLCreateStringByAddingPercentEscapes(nil, string as CFString!, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }

}











