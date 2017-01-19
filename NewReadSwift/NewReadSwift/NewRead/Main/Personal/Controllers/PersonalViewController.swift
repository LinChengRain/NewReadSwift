//
//  PersonalViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/13.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let identifier = "Personal_Cell"
    
    var dataArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //加载数据
        loadData()
        //子视图
        loadSubviews()
    }

    //MARK: - 加载数据
    func loadData(){
    
        dataArray = ["设置","天气","快递查询","背景"]
    }
    
    //MARK: - 加载子视图
    func loadSubviews(){
    
    
        self.view.addSubview(tableview)
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
    
    }
    //MARK: - private 懒加载
    private lazy var tableview:UITableView = {
    
        let tableview:UITableView = UITableView.init(frame: self.view.bounds, style: .plain)
        //设置代理
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 44
        tableview.showsVerticalScrollIndicator = false
        tableview.backgroundColor = UIColor.clear
        
        tableview.tableFooterView = UIView.init()
        return tableview
    }()
    
    
    
    //MARK: - UITableViewDelegate And UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击第\(indexPath.row)个单元格")
        
        if indexPath.row == 2 {
            let expressVC:ExpressDetailViewController = ExpressDetailViewController()
            navigationController?.pushViewController(expressVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:PHeaderView = PHeaderView.init(frame: CGRect(x:0,y:0,width:K_Screen_Width,height:100))
        headerView.backgroundColor = UIColor.red
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
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
