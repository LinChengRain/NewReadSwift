//
//  ExpressDetailViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/16.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit
import WebKit

class ExpressDetailViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    var lastUrl:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {

//        print(lastUrl )
        
        
//        webview.loadHTMLString(lastUrl!, baseURL: nil)
//        if let lastUrl = lastUrl {
//            print(lastUrl )
//
//            let request:URLRequest = URLRequest.init(url: URL.init(string: lastUrl)!)
//            webview.load(request)
//        }
//        let request:URLRequest = URLRequest.init(url: URL.init(string: lastUrl!)!)
        
    }
    //MARK: - 加载子视图
    func loadSubviews(){
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(webview)
        
    
        let request:URLRequest = URLRequest.init(url: URL.init(string: Express_Base_Url)!)
        webview.load(request)
    }
    //MARK: - private 懒加载
    private lazy var webview:WKWebView = {
    
        let webview:WKWebView = WKWebView.init(frame: CGRectMake(0, 0, K_Screen_Width, K_Screen_Height))
        webview.uiDelegate = self
        webview.navigationDelegate = self
        
        return webview
    }()
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        navigation.accessibilityElementsHidden = true
        print("开始加载")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
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
