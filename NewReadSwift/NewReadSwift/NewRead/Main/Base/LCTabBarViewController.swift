//
//  LCTabBarViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class LCTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addMainController()
    }

     //MARK:-1：添加子控制器
    private func addMainController(){
    
        //首页
        let home = HomeViewController()
        addChildController(home, "首页", "tabBar_home_Normal", "tabBar_home_Selected")
        
        //电影
        let movie = MovieViewController()
        addChildController(movie, "电影", "tabBar_movie_Normal", "tabBar_movie_Selected")
        
        //个人
        let personal = PersonalViewController()
        addChildController(personal, "我的", "tabBar_person_Normal", "tabBar_person_Selected")

    }
    
    
    
    //MARK: - private :add childVC
    private func addChildController(_ controller: UIViewController,_ title:String,_ normalImage:String,_ selectedImage:String)->Void {
        
        controller.title = title
        // 设置图标
        controller.tabBarItem.image = UIImage.init(named: normalImage)
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.lightGray
        } else {
            // Fallback on earlier versions
        }
        
        //被选中图标
        controller.tabBarItem.selectedImage = UIImage.init(named: selectedImage)
        self.tabBar.tintColor = UIColor.colorWithHexString(hex:"#d81e06")
         // 添加子控制器
        let lcNavigationVC = LCNavigationViewController.init(rootViewController: controller)
        addChildViewController(lcNavigationVC)
        
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
