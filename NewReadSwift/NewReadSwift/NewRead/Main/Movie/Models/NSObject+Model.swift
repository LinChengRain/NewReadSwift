//
//  NSObject+Model.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import Foundation

class NSObject_Model: NSObject {

}

/**
 数据类型
 */
public enum data_type :Int{
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Null
    case Unknown
}

private let lc_queue = DispatchQueue.init(label: "lc_lcjmodel_queie_serial")
extension NSObject{
    
    /**
     任意类型  如果传入的是任意类型 主动转成字典 如果不成功返回空对象
     
     - parameter obj: 任意对象
     
     - returns: 模型
     */
    static func lc_objToModel(obj:AnyObject?)->NSObject?{
        if let dic = obj as? [String:AnyObject]{
            return lc_dicToModel(dic: dic)
        }
        return nil
    }
    
    /**
     字典转模型
     
     - parameter dic: 字典
     - returns: 模型
     */
    static func lc_dicToModel(dic:[String:AnyObject])->NSObject?{
        if dic.first == nil {
            return nil
        }
        let t = (self.classForCoder() as! NSObject.Type).init()
        let properties = t.lc_modelPropertyClass()
        for (k,v) in dic{
            if t.lc_getVariableWithClass(cla: self.classForCoder(), varName: k){ //如果存在这个属性
                if t.lc_isBasic(type: t.lc_getType(v: v)){
                    //                    print(t.classForCoder)
                    //基础类型 可以直接赋值
                    t.setValue(v,forKey: k)
                }else{
                    //复杂类型
                    let type = t.lc_getType(v: v)
                    if type == .Dictionary{
                        //是一个对象类型
                        if let dic1 = v as? [String : AnyObject]{
                           
                            if  t.responds(to: #selector(NSObject.lc_modelPropertyClass)){
                                if let properties = properties{
                                    if  t.value(forKey: k) == nil{
                                        //初始化
                                        let obj = (properties[k] as! NSObject.Type).init()
                                        t.setValue(obj, forKey: k)
                                    }
                                }
                            }
                            if let obj = t.value(forKey: k){
                                (obj as AnyObject).setDicValue(dic1: dic1) //有对象就递归

                                
//                                setDicValue(dic1)                          
                            }
                        }
                    }else if type == .Array{
                        //数组类型
                        if let arr = v as? [AnyObject]{
                            if !arr.isEmpty {
                                if t.lc_isBasic(type: t.lc_getType(v: arr.first!)) {
                                    //数组中的内容是基本类型
                                    t.setValue(arr, forKey: k)
                                }else{
                                    if t.lc_getType(v: arr.first!) == .Dictionary{
                                        //对象数组
                                        var objs:[NSObject] = []
                                        for dic in arr{
                                            if let properties = properties{
                                                let obj = (properties[k] as! NSObject.Type).init()
                                                objs.append(obj)
                                                lc_queue.async {
                                                    //串行对列执行
                                                    obj.setDicValue(dic1: dic as! [String : AnyObject])
                                                }
                                            }
                                        }
                                        t.setValue(objs, forKey: k)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
        return t
    }
    
    
    /**
     逐级递归 遍历赋值给对象
     
     - parameter dic1: 字典
     */
    func setDicValue(dic1:[String : AnyObject]){
        for (k,v) in dic1{
            
            if self.lc_getVariableWithClass(cla: self.classForCoder, varName: k){
                //判断是否存在这个属性
                if self.lc_isBasic(type: self.lc_getType(v: v)){
                    //设置基本类型
                    if self.lc_getType(v: v) == .Bool{
                        //TODO: -Bool类型怎么处理  不懂
                        //                      self.setValue(Bool(v as! NSNumber), forKey: k)
                        
                    }else{
                        self.setValue(v, forKey: k)
                    }
                }else if self.lc_getType(v: v) == .Dictionary{
                    if let dic1 = v as? [String : AnyObject]{
                        if self.responds(to:#selector(NSObject.lc_modelPropertyClass)){
                            if let properties = self.lc_modelPropertyClass(){
                                if  self.value(forKey: k) == nil{
                                    //初始化
                                    let obj = (properties[k] as! NSObject.Type).init()
                                    self.setValue(obj, forKey: k)
                                }
                            }
                        }
                        if let obj = self.value(forKey: k){
                            (obj as AnyObject).setDicValue(dic1: dic1)
                            //递归
                        }
                    }
                }
                
            }
        }
    }
    
    
    /**
     判断类型
     
     - parameter v: 参数
     
     - returns: 类型
     */
    private func lc_getType(v:AnyObject)->data_type{
        switch v{
        case let number as NSNumber:
            if number.lc_isBool {
                return .Bool
            } else {
                return .Number
            }
        case _ as String:
            return .String
        case _ as NSNull:
            return .Null
        case _ as [AnyObject]:
            return .Array
        case _ as [String : AnyObject]:
            return .Dictionary
        default:
            return .Unknown
        }
    }
    
    
    /**
     是否为基础类型
     
     - parameter type: 类型
     
     - returns: true/false
     */
    private func lc_isBasic(type:data_type)->Bool{
        if type == .Bool || type == .String || type == .Number {
            return true
        }
        return false
    }
    
    /**
     留给子类有实体属性的去继承
     
     - returns: k , 实体
     */
    func lc_modelPropertyClass()->[String:AnyClass]?{
        return nil
    }
    
    /**
     判断对象中是否包含某个属性
     
     - parameter cla:     类
     - parameter varName: 变量名
     
     - returns: bool
     */
    func lc_getVariableWithClass(cla:AnyClass , varName:String)->Bool{
        var outCount:UInt32 = 0
        let ivars = class_copyIvarList(cla, &outCount)
        for i in 0..<outCount{
            let property = ivars?[Int(i)]
            let keyName = String.init(cString:ivar_getName(property))
//            fromCString(ivar_getName(property))
            if keyName == varName{
                free(ivars)
                return true
            }
        }
        free(ivars)
        return false
    }
    
}

private let lc_trueNumber = NSNumber(value: true)
private let lc_falseNumber = NSNumber(value: false)
private let lc_trueObjCType = String.init(cString: lc_trueNumber.objCType)
//fromCString(zz_trueNumber.objCType)
private let lc_falseObjCType = String.init(cString:lc_falseNumber.objCType)
// MARK: - 判断是否为bool
extension NSNumber {
    var lc_isBool:Bool {
        get {
            let objCType = String.init(cString:self.objCType)
            if (self.compare(lc_trueNumber) == ComparisonResult.orderedSame && objCType == lc_trueObjCType)
                || (self.compare(lc_falseNumber) == ComparisonResult.orderedSame && objCType == lc_falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}
