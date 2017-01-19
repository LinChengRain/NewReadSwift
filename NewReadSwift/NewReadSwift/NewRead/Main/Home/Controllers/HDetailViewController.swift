//
//  HDetailViewController.swift
//  NewReadSwift
//
//  Created by Changlin Yu on 2017/1/14.
//  Copyright © 2017年 LinChengRain. All rights reserved.
//

import UIKit
import WebKit
class HDetailViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {

    var url:String? = nil
    var key:String? = nil
    
    /** 进度条 */
    private var progressView : UIProgressView? = nil
    private let keyPathForProgress : String = "estimatedProgress"
    private let keyPathForTitle : String = "title"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        
        loadSubviews()
        
        
       
        webview.addObserver(self, forKeyPath: keyPathForProgress, options:.new, context: nil)
    
       webview.addObserver(self,forKeyPath:keyPathForTitle, options:.new,context:nil)
    }

    
    
    //MARK: - 加载子视图
    func loadSubviews() -> Void {
        
        self.view.addSubview(webview)

        progressView = UIProgressView.init(frame: CGRect(x:0,y: 63, width:self.view.frame.size.width,height: 4))
        progressView?.progress = 0.0
        progressView?.tintColor = UIColor.red
        
         // 这里可以改进度条颜色
        self.webview.addSubview(progressView!)
        
        let request = URLRequest.init(url: URL.init(string: url!)!)
        self.webview.load(request)
    }
    //MARK: - 懒加载
    private lazy var webview:WKWebView={
    
        let webview:WKWebView = WKWebView.init(frame: self.view.bounds)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        
        return webview
    }()
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    
    //MARK: - KVO:检测进度和标题
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == keyPathForProgress {
           progressView?.alpha = 1.0
           progressView?.setProgress(Float(webview.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(self.webview.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                    self.progressView?.alpha = 0.0
                }, completion: { (finished:Bool) -> Void in
                    self.progressView?.progress = 0
                })
            }
        }
        
        if keyPath == keyPathForTitle {
            self.title = self.webview.title
        }
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: keyPathForTitle)
        webview.removeObserver(self, forKeyPath: keyPathForProgress)
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
