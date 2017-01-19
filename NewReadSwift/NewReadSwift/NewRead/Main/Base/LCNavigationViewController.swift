//
//  LCNavigationViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class LCNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationBarChange()
    }

    //MARK: - 导航栏样式
    func navigationBarChange(){
    
        let appearance:UINavigationBar = UINavigationBar.appearance()
        //导航栏背景色
        appearance.barTintColor = RGBColor(20, 155, 213)
        // *修改导航栏文字颜色
        
        appearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        // *修改导航栏按钮颜色
        appearance.tintColor = UIColor.white
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //修改状态栏颜色
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        
//        return UIStatusBarStyle.lightContent
//        
//    }

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
