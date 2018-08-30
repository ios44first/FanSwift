//
//  GameViewController.swift
//  FanSwift
//
//  Created by 于建祥 on 17/9/21.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

let TIMEMAX = 35

class GameViewController: UIViewController, UIAlertViewDelegate
{
    var imageBackView: UIImageView?
    var soundButton: UIButton?
    var refreshButton: UIButton?
    var timeTips: UILabel?
    
    var timer: NSTimer?
    var timeCount = TIMEMAX
    var score = 0
    var tempImageView:MyImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //加载背景音乐
        MusicManager.playBackGroudMusic()
        
        //初始化界面
        setupView()
        
        //创建并启动计时器
        creatTimer()
        
        //排版需要翻看的图片
        setupImageArray()
        
        //随机加载蔬菜图片 并展示
        loadAndShowImage()
    }
    
    /******************************** 初始化 ************************************/
    
    //初始化 主界面
    func setupView()
    {
        let backView = UIImageView.init(frame: self.view.bounds)
        backView.image = UIImage.init(named: "game_bg")
        self.view.addSubview(backView)
        
        let percent:CGFloat = 584.0/453.0  //长度 占 高度 的比例
        let imageBackView_width = (kScreenHeight-40) * percent
        imageBackView = UIImageView.init(frame: CGRectMake(30.0*kScreenWidth/480.0, 20, imageBackView_width, kScreenHeight-40))
        imageBackView!.image = UIImage.init(named: "game_box")
        imageBackView?.userInteractionEnabled = true
        self.view.addSubview(imageBackView!)
        
        soundButton = UIButton(type: UIButtonType.Custom)
        soundButton!.frame = CGRectMake(kScreenWidth-60, 30, 50, 44)
        soundButton!.setBackgroundImage(UIImage(named: "openSound"), forState: UIControlState.Normal)
        soundButton!.addTarget(self, action: #selector(soundOnOff), forControlEvents: UIControlEvents.TouchUpInside)
        soundButton!.tag = 100;
        self.view.addSubview(soundButton!)
        
        refreshButton = UIButton(type: UIButtonType.Custom)
        refreshButton!.frame = CGRectMake(kScreenWidth-60, 80, 50, 44)
        refreshButton!.setBackgroundImage(UIImage(named: "refresh"), forState: UIControlState.Normal)
        refreshButton!.addTarget(self, action: #selector(refreshImage), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(refreshButton!)
        
        timeTips = UILabel(frame: CGRectMake(kScreenWidth-60, 130, 50, 44))
        timeTips?.font = UIFont.boldSystemFontOfSize(35)
        timeTips?.textAlignment = NSTextAlignment.Center
        timeTips?.textColor = UIColor.redColor()
        timeTips?.text = String(format: "%d", timeCount)
        self.view.addSubview(timeTips!)
        
        //注意 点击鸵鸟就退出了 （懒得加按钮了😂）
        let bird = UIImageView(frame: CGRectMake(kScreenWidth-130, kScreenHeight-150, 120, 143))
        bird.image = UIImage(named: "tuo1")
        bird.userInteractionEnabled = true
        bird.tag = 2000
        self.view.addSubview(bird)
        var birdImageArray = [UIImage]()
        for i in 1...7
        {
            let imageName = String("tuo\(i)")
            birdImageArray.append(UIImage(named: imageName)!)
        }
        bird.animationImages = birdImageArray
        bird.animationDuration = 1
        bird.animationRepeatCount = -1
        bird.startAnimating()
    }
    
    //初始化 计时器
    func creatTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(changeCount), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    //初始化 图片矩阵
    func setupImageArray()
    {
        let imageMargin:CGFloat = 20.0
        let imageSpace:CGFloat = 10.0
        let tempBackFrame = imageBackView?.frame
        let imageWidth = ((tempBackFrame?.size.width)! - imageSpace*4-imageMargin*2)/5.0
        
        for i in 0..<20
        {
            let imageX = CGFloat(Int(i%5))*(imageWidth+imageSpace) + imageMargin
            let imageY = CGFloat(Int(i/5))*(imageWidth+imageSpace/2.0-1) + imageMargin - 2
            let imageFruit = MyImageView(frame: CGRectMake(CGFloat(imageX), CGFloat(imageY), imageWidth, imageWidth))
            imageFruit.image = UIImage(named: "contrary")
            imageFruit.userInteractionEnabled = false
            imageFruit.tag = i+1
            imageBackView?.addSubview(imageFruit)
        }
    }
    
    /******************************** 随机布局图片 ************************************/
    
    //随机加载图片并展示、翻回
    func loadAndShowImage()
    {
        loadFruit()
        turnAllLeft()
        self.performSelector(#selector(turnAllRight), withObject: nil, afterDelay: 3)
    }
    
    //根据随机数 随机布局待翻的图片
    func loadFruit()
    {
        let arrayFruit = randFruit()
        let arrayTag = randTag()
        var tempIndex = 0
        for i in 0..<10
        {
            //根据蔬菜的随机数 取出一种蔬菜图片
            let num = arrayFruit.objectAtIndex(i).intValue
            let fruitName:NSString = NSString(format: "fruit%d.png", num)
            let fruitImage = UIImage(named: fruitName as String)
            //根据tag标记随机数 取出一对问号图片MyImageView
            let tag1 = arrayTag.objectAtIndex(tempIndex).intValue
            let myImg1:MyImageView = imageBackView!.viewWithTag(Int(tag1)) as! MyImageView
            tempIndex = tempIndex + 1
            let tag2 = arrayTag.objectAtIndex(tempIndex).intValue
            let myImg2:MyImageView = imageBackView!.viewWithTag(Int(tag2)) as! MyImageView
            tempIndex = tempIndex + 1
            //给这一对图片 赋值 相同的蔬菜图片和标记
            myImg1.fruit = fruitImage
            myImg2.fruit = fruitImage
            myImg1.flag = i
            myImg2.flag = i
        }
    }
    
    //蔬菜随机数 18种蔬菜取出10种
    func randFruit() -> NSArray
    {
        let randArray = NSMutableArray()
        while randArray.count < 10
        {
            let num = arc4random_uniform(18)+1 //[0，18）+ 1 = [1,18]
            if !randArray.containsObject(NSNumber(int: Int32(num)))
            {
                randArray.addObject(NSNumber(int: Int32(num)))
            }
        }
        return randArray
    }
    
    //1到20随机数 打乱imageView
    func randTag() -> NSArray
    {
        let randArray = NSMutableArray()
        while randArray.count < 20
        {
            let num = arc4random_uniform(20)+1 //[0，20）+ 1 = [1,20]
            if !randArray.containsObject(NSNumber(int: Int32(num)))
            {
                randArray.addObject(NSNumber(int: Int32(num)))
            }
        }
        return randArray
    }
    
    /******************************** 翻图片 ************************************/
    
    //全部左翻
    func turnAllLeft()
    {
        for i in 1..<21
        {
            let myImage:MyImageView = imageBackView!.viewWithTag(i) as! MyImageView
            myImage.turnLeft()
        }
    }
    
    //全部右翻
    func turnAllRight()
    {
        for i in 1..<21
        {
            let myImage:MyImageView = imageBackView!.viewWithTag(i) as! MyImageView
            myImage.turnRight()
        }
    }
    
    //当前点击的两张图 翻转回问号
    func turnFruit(myImage:MyImageView)
    {
        myImage.turnRight()
        tempImageView?.turnRight()
        tempImageView = nil
    }
    
    /******************************** Action ************************************/

    //核心逻辑 点击图片的处理
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        if ((touch.view!.isMemberOfClass(MyImageView.self)))
        {
            MusicManager.playClickMusic()
            let myImg:MyImageView = touch.view as! MyImageView
            myImg.turnLeft()
            if tempImageView == nil
            {
                tempImageView = myImg
            }
            else
            {
                if tempImageView!.flag == myImg.flag
                {
                    MusicManager.playRightMusic()
                    tempImageView = nil
                    score = score + 1
                    if score >= 10
                    {
                        //存储用时
                        let num = TIMEMAX - timeCount
                        let timeValue = NSString(format: "%d", num)
                        let dateFormat = NSDateFormatter()
                        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let timeKey = dateFormat.stringFromDate(NSDate())
                        
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        let timeArray = userDefault.valueForKey(UD_TIME)
                        let array = NSMutableArray()
                        if timeArray != nil
                        {
                            array.addObjectsFromArray(timeArray as! [AnyObject])
                        }
                        let dic = [timeKey:timeValue]
                        array.addObject(dic)
                        userDefault .setValue(array, forKey: UD_TIME)
                        userDefault.synchronize()
                        
                        //终止计时
                        timer?.invalidate()
                        //过关动画
                        successAnimation()
                    }
                }
                else
                {
                    self.performSelector(#selector(turnFruit), withObject: myImg, afterDelay: 0.5)
                }
            }
        }
        if touch.view?.tag == 1000
        {
            let successImageView:UIImageView = self.view.viewWithTag(1000) as! UIImageView
            successImageView.removeFromSuperview()
            refreshImage()
        }
        else if touch.view?.tag == 2000
        {
            timer?.invalidate()
            self.dismissViewControllerAnimated(true, completion: {
                MusicManager.stopBackGroudMusic()
            })
        }
    }
    
    //过关的动画
    func successAnimation()
    {
        var array = [UIImage]()
        for i in 1..<13
        {
            let imageName = NSString(format: "salute%d-hd.png", i)
            array.append(UIImage(named: imageName as String)!)
        }
        let successView = UIImageView(frame: CGRectMake(20, 20, 440, 300))
        successView.tag = 1000
        successView.animationImages = array
        successView.animationDuration = 1
        successView.animationRepeatCount = -1
        successView.startAnimating()
        successView.userInteractionEnabled = true
        self.view.addSubview(successView)
    }
    
    //背景音乐开关
    func soundOnOff(sender: UIButton)
    {
        if MusicManager.isplayingBackGroudMusic()  //关闭声音
        {
            MusicManager.stopBackGroudMusic()
            sender.setBackgroundImage(UIImage(named: "closeSound"), forState: UIControlState.Normal)
            
        }
        else                  //打开声音
        {
            MusicManager.playBackGroudMusic()
            sender.setBackgroundImage(UIImage(named: "openSound"), forState: UIControlState.Normal)
            
        }
    }
    
    //刷新
    func refreshImage()
    {
        timeCount = TIMEMAX
        timeTips?.text = String(format: "%d", timeCount)

        if timer?.valid == true
        {
            timer?.fire()
        }
        else
        {
            self.creatTimer()
        }
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        loadAndShowImage()
        
        tempImageView = nil
        
        score = 0
    }
    
    //计时
    func changeCount()
    {
        if timeCount != -1
        {
            timeTips?.text = String(format: "%d", timeCount)
            timeCount -= 1
        }
        else
        {
            //Game over
            timer?.invalidate()
            let alertView = UIAlertView.init(title: "Game Over", message: "你的瞬时记忆太差了！是否重来？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再来一次")
            alertView.show()
            score = 0
        }
    }
    
    //alert协议
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex != alertView.cancelButtonIndex
        {
            self.refreshImage()
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: {
                MusicManager.stopBackGroudMusic()
            })
        }
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
