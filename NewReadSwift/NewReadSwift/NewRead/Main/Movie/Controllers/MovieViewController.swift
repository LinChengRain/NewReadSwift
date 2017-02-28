//
//  MovieViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    var dataArray:Array<Any>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.yellow
        
//        loadData()
        
        loadSubview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()

    }
    ///MARK: - 加载数据
    func loadData() {
        let movieViewModel = MovieViewModel()
        
        //属性
        let city = "苏州"
        let dtype = "json"

        
        weak var weakSelf = self
        movieViewModel.sendMovieNews(dtype: dtype, city: city, success: { (response) in
            
//          weakSelf?.dataArray = response
            weakSelf?.tableview.dataArray = response
        }) { (error) in
            
        }
    }
    ///MARK: - 创建子视图
    func loadSubview() {
        
        self.view.addSubview(tableview)
        
    }
    
    ///MARK: - 创建子视图
     private lazy var tableview:MovieListTableView = {
    
        let tableview = MovieListTableView.init(frame: CGRectMake(0, 0, K_Screen_Width, K_Screen_Height), style: .plain)
        
        return tableview
    }()

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
