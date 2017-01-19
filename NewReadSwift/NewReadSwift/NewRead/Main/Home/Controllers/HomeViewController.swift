//
//  HomeViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    //数据数组，添加懒加载
    lazy var dataList: [NewsModel] = {
        return []
    }()
    //拉刷新控制器
    var refreshControl = UIRefreshControl()
    
    let identifier = "NewsViewCell" //重用标记
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        loadData()

        loadSubview()
    }
    
    
    func loadData(){
        
        
        let newsModel = NewsViewModel()
        weak var weakSelf = self
        newsModel.newsData(refreshData: true, success: { (data) in
            weakSelf?.dataList = data
            
            DispatchQueue.main.async {
                weakSelf?.tableview.reloadData()
                weakSelf?.refreshControl.attributedTitle = NSAttributedString(string:"数据加载成功")
                weakSelf?.refreshControl.endRefreshing()
            
            }

        }) { (error) in
            
            DispatchQueue.main.async {
                weakSelf?.refreshControl.attributedTitle = NSAttributedString(string:"数据加载失败...")
                weakSelf?.refreshControl.endRefreshing()
            }
        }
    }

    
    //MARK - 加载子视图
    func loadSubview(){
    
        
        self.view.addSubview(tableview)
        //注册重用单元格
        tableview.register(UINib.init(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        
        //添加刷新
        refreshControl.addTarget(self, action: #selector(refreshData),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableview.addSubview(refreshControl)
        refreshControl.beginRefreshing()
//        refreshData()
    }
    
    //MARK: - 懒加载
    private lazy var tableview : UITableView = {
    
        let tableview:UITableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 120

        return tableview
    }()

    // 刷新数据
    func refreshData() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "数据加载中......")
        //移除老数据
        self.dataList.removeAll()
        
        loadData()
        
//        self.tableview.reloadData()
    }
    
    //MARK: - UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell:NewsViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsViewCell
        
        
        if self.dataList.count == 0 {
            return cell
        }
        let model:NewsModel = self.dataList[indexPath.row]
        cell.author.text = model.author_name
        cell.date.text = model.date
        cell.title.text = model.title
        
        
        cell.thumbnail_pic_s.image = UIImage.init(data: try!Data.init(contentsOf: URL.init(string: model.thumbnail_pic_s!)!))
        
        if model.thumbnail_pic_s02 != nil && model.thumbnail_pic_s02?.characters.count != 0 {
            cell.thumbnail_pic_s02.image = UIImage.init(data: try!Data.init(contentsOf: URL.init(string: model.thumbnail_pic_s02!)!))
        }
        if model.thumbnail_pic_s03 != nil &&  model.thumbnail_pic_s03?.characters.count != 0 {
             cell.thumbnail_pic_s03.image = UIImage.init(data: try!Data.init(contentsOf: URL.init(string: model.thumbnail_pic_s03!)!))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.dataList[indexPath.row]
        
        
        let hDetailVC = HDetailViewController()
        hDetailVC.url = model.url
        hDetailVC.key = model.uniquekey
        self.navigationController?.pushViewController(hDetailVC, animated: true)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if !refreshControl.isRefreshing {
            refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        }
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
