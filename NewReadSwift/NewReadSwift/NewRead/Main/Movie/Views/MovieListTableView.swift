//
//  MovieListTableView.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/20.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit

private let identifier = "MovieDetailCell"

class MovieListTableView: UITableView,UITableViewDataSource,UITableViewDelegate{

    //数据源
    var _dataArray:[MovieListModel] = []
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
       
        //设置代理数据源
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear
        self.tableFooterView = UIView.init()
        //注册单元格
        self.register(UINib.init(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataArray:[MovieListModel]{
        set{
            _dataArray = newValue
            
            self.reloadData()
        }
        get{
            return _dataArray
        }
    }
    ///MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rowArray = self.dataArray[section]
        let data = rowArray.data
        return data!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell:MovieDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieDetailCell
        
        //获取数据
        let rowArray = self.dataArray[indexPath.section]
        print( (rowArray.data! as NSArray)[indexPath.row])
//        let data = (rowArray.data! as NSArray)[indexPath.row] 
//        
//        ///赋值
//        cell.tvTitleLabel.text = (data as AnyObject).tvTitle
//        cell.subHeadLabel.text = (data as AnyObject).subHead
//        cell.gradeLabel.text = "\((data as AnyObject).grade?.doubleValue) 分"
//        cell.typeLabel.text = String.init(format: "%@/%@", ((data as AnyObject).type?.data?[0].name)!,(data.type?.data?[0].name)!)
//        
//        let urlData = try?Data.init(contentsOf: URL.init(string: (data.iconlinkUrl)!)!)
//        cell.posterImageView.image = UIImage.init(data: urlData!)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //数据源
        let rowArray = self.dataArray[section]
        
        let headerView:UIView = UIView.init(frame: CGRectMake(0, 0, K_Screen_Width, 30))
        
        let titleLabel = UILabel.init(frame: CGRectMake(0, 0, K_Screen_Width, 30))
        titleLabel.text = rowArray.name
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
