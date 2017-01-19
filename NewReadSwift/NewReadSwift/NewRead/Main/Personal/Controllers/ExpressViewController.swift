//
//  ExpressViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class ExpressViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        //加载子视图
        loadSubviews()
    }

    //MARK: - 加载子视图
    func loadSubviews(){
    
        self.view.addSubview(typeTextFiled)
        self.view.addSubview(postidTextFiled)
        
        self.view.addSubview(sendButton)
    }
    
    //MARK: - private 懒加载
    ///快递公司编码
    private lazy var typeTextFiled:UITextField = {
    
        let textField:UITextField = UITextField.init(frame: CGRect(x:50,y:100,width:self.view.width - 100,height:40))
            textField.placeholder = "查询的快递公司"
            textField.textColor = UIColor.black
        return textField
    }()
    ///快递单号
    private lazy var postidTextFiled:UITextField = {
        
        let textField:UITextField = UITextField.init(frame: CGRect(x:50,y:self.typeTextFiled.bootom + 30,width:self.view.width - 100,height:40))
        textField.placeholder = "查询的快递单号"
        textField.textColor = UIColor.black
        return textField
    }()
    
    ///send
    private lazy var sendButton:UIButton = {
        let button:UIButton = UIButton.init(type:UIButtonType.custom)
        button.frame = CGRectMake(50,200,self.view.width - 100, 30)
        button.setTitle("查询", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        
        button.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return button
    }()

    //MARK: - Click Method
    func sendAction() -> Void {
        
        if postidTextFiled.text?.characters.count == 0 {
            return
        }
        if typeTextFiled.text?.characters.count == 0 {
            return
        }
        
        let result = ExpressViewModel()
        result.send(com: postidTextFiled.text!, no: typeTextFiled.text!, success: { (dic) in
            
            let result:ExpressModel = dic["result"] as! ExpressModel
            let listArray:Array<ExpressListModel> = dic["list"] as! Array<ExpressListModel>
            
            DispatchQueue.main.async {
                
//                let expressDVC = ExpressDetailViewController()

//                self.navigationController?.pushViewController(expressDVC, animated: true)
            }
        }) { (error) in
            
        }
//        let expressDVC = ExpressDetailViewController()
//        expressDVC.lastUrl = Express_Base_Url + "?type=\(typeTextFiled.text!)&postid=\(postidTextFiled.text!)"
//       navigationController?.pushViewController(expressDVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
