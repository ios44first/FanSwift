//
//  ViewController.swift
//  FanSwift
//
//  Created by 于建祥 on 17/9/18.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.backgroundColor = UIColor.redColor()
        
        setupView()
        
    }
    
    func setupView()
    {
        //背景
        let backView = UIImageView.init(frame: self.view.bounds)
        backView.image = UIImage.init(named: "index_bg")
//        backView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backView)
        
        //标题
        let percentWidth = kScreenWidth/480.0
        let percentHeight = kScreenHeight/320.0
        
        let name1 = UILabel.init(frame: CGRectMake(30*percentWidth, 30*percentHeight, 60, 60))
        name1.text = "翻"
        name1.textColor = UIColor.blueColor()
        name1.font = UIFont.boldSystemFontOfSize(60)
        self.view.addSubview(name1)
        
        let name2 = UILabel.init(frame: CGRectMake((30+60)*percentWidth, (30+80)*percentHeight, 60, 60))
        name2.text = "翻"
        name2.textColor = UIColor.redColor()
        name2.font = UIFont.boldSystemFontOfSize(60)
        self.view.addSubview(name2)
        
        let name3 = UILabel.init(frame: CGRectMake(50*percentWidth, (30+80+80)*percentHeight, 60, 60))
        name3.text = "看"
        name3.textColor = UIColor.orangeColor()
        name3.font = UIFont.boldSystemFontOfSize(60)
        self.view.addSubview(name3)
        
        let author = UILabel.init(frame: CGRectMake(0, kScreenHeight-20, kScreenWidth, 20))
        author.text = "2017©️于建祥"
        author.textColor = UIColor.blackColor()
        author.font = UIFont.boldSystemFontOfSize(12)
        author.textAlignment = NSTextAlignment.Center
        self.view.addSubview(author)
        
        //配图 鸵鸟
        let birdView = UIImageView.init(frame: CGRectMake(kScreenWidth-170, kScreenHeight-210, 160, 191))
        birdView.image = UIImage.init(named: "tuo1")
        self.view.addSubview(birdView)
        
        //菜单 按钮
        let button_width:CGFloat = 150.0
        let button_left = (kScreenWidth-button_width)/2.0
        let button_top = (kScreenHeight-50*4)/2.0 + 30
        
        let item1 = UIButton(type: UIButtonType.Custom)
        item1.frame = CGRectMake(button_left, button_top, button_width, 40)
        item1.setTitle("开始游戏", forState: UIControlState.Normal)
        item1.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
        item1.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        item1.addTarget(self, action: #selector(button_action), forControlEvents: UIControlEvents.TouchUpInside)
        item1.tag = 1
        item1.layer.shadowColor = UIColor.orangeColor().CGColor
        item1.layer.shadowOffset = CGSizeMake(0, 1)
        item1.layer.shadowOpacity = 5
        item1.layer.shadowRadius = 5.0
        self.view.addSubview(item1)
        
        let item2 = UIButton(type: UIButtonType.Custom)
        item2.frame = CGRectMake(button_left, button_top+50, button_width, 40)
        item2.setTitle("成绩排行", forState: UIControlState.Normal)
        item2.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
        item2.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        item2.addTarget(self, action: #selector(button_action), forControlEvents: UIControlEvents.TouchUpInside)
        item2.tag = 2
        item2.layer.shadowColor = UIColor.orangeColor().CGColor
        item2.layer.shadowOffset = CGSizeMake(0, 1)
        item2.layer.shadowOpacity = 5
        item2.layer.shadowRadius = 5.0
        self.view.addSubview(item2)
        
        let item3 = UIButton(type: UIButtonType.Custom)
        item3.frame = CGRectMake(button_left, button_top+100, button_width, 40)
        item3.setTitle("帮  助", forState: UIControlState.Normal)
        item3.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
        item3.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        item3.addTarget(self, action: #selector(button_action), forControlEvents: UIControlEvents.TouchUpInside)
        item3.tag = 3
        item3.layer.shadowColor = UIColor.orangeColor().CGColor
        item3.layer.shadowOffset = CGSizeMake(0, 1)
        item3.layer.shadowOpacity = 5
        item3.layer.shadowRadius = 5.0
        self.view.addSubview(item3)
        
        let item4 = UIButton(type: UIButtonType.Custom)
        item4.frame = CGRectMake(button_left, button_top+150, button_width, 40)
        item4.setTitle("关  于", forState: UIControlState.Normal)
        item4.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
        item4.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        item4.addTarget(self, action: #selector(button_action), forControlEvents: UIControlEvents.TouchUpInside)
        item4.tag = 4
        item4.layer.shadowColor = UIColor.orangeColor().CGColor
        item4.layer.shadowOffset = CGSizeMake(0, 1)
        item4.layer.shadowOpacity = 5
        item4.layer.shadowRadius = 5.0
        self.view.addSubview(item4)
        
    }
    
    func button_action(sender: UIButton)
    {
        switch sender.tag
        {
        case 1:
            self.presentViewController(GameViewController(), animated: true, completion: { })
            NSLog("开始游戏")
        case 2:
            let navi = UINavigationController(rootViewController: ScoreListViewController())
            self.presentViewController(navi, animated: true, completion: { })
            NSLog("成绩排行")
        case 3:
            let navi = UINavigationController(rootViewController: HelpViewController())
            self.presentViewController(navi, animated: true, completion: { })
            NSLog("帮助")
        case 4:
            let navi = UINavigationController(rootViewController: AboutViewController())
            self.presentViewController(navi, animated: true, completion: { })
            NSLog("关于")
        default:
            NSLog("tag 超出识别范围");
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

