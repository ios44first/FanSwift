//
//  AboutViewController.swift
//  FanSwift
//
//  Created by 于建祥 on 17/10/31.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate
{
    
    var showType = false
    var activity :UIActivityIndicatorView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = item
        
        if showType
        {
            showWebView()
        }
        else
        {
            showTextImage()
        }
    }
    
    func showTextImage()
    {
        self.title = "关 于"
        
        let icon = UIImageView(frame: CGRectMake((kScreenWidth-100)/2.0, 50, 100, 100))
        icon.image = UIImage(named: "swift")
        self.view.addSubview(icon)
        
        let tips = UILabel(frame: CGRectMake(50, 170, kScreenWidth-100, 70))
        tips.font = UIFont.systemFontOfSize(15)
        tips.numberOfLines = 0
        tips.textColor = UIColor.blackColor()
        tips.textAlignment = NSTextAlignment.Left
        tips.text = "        本游戏纯粹用来学习swift使用，之前写过Objective-C版本的，这是翻成的swift版，并做了一些修改和升级。学习交流请点击关注我的博客"
        self.view.addSubview(tips)
        
        let item1 = UIButton(type: UIButtonType.Custom)
        item1.frame = CGRectMake(50, 240, kScreenWidth-100, 30)
        item1.setTitle("http://blog.csdn.net/yujianxiang666", forState: UIControlState.Normal)
        item1.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        item1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        item1.addTarget(self, action: #selector(button_action), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(item1)
        
        let author = UILabel.init(frame: CGRectMake(0, kScreenHeight-20, kScreenWidth, 20))
        author.text = "2017©️于建祥"
        author.textColor = UIColor.blackColor()
        author.font = UIFont.boldSystemFontOfSize(12)
        author.textAlignment = NSTextAlignment.Center
        self.view.addSubview(author)
    }
    
    func showWebView()
    {
        self.title = "如鱼得水的博客"
        
        let webView = UIWebView(frame: self.view.bounds)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://blog.csdn.net/yujianxiang666")!))
        webView.delegate = self
        self.view.addSubview(webView)
        
        activity = UIActivityIndicatorView(frame: self.view.bounds)
        activity?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activity!)
    }

    func goBack()
    {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func button_action()
    {
        let about = AboutViewController()
        about.showType = true
        let navi = UINavigationController(rootViewController: about)
        self.presentViewController(navi, animated: true, completion: { })
    }
    
    //webView 代理
    func webViewDidStartLoad(webView: UIWebView) {
        activity?.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activity?.stopAnimating()
        activity?.removeFromSuperview()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
