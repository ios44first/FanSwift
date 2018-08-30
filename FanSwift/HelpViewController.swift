//
//  HelpViewController.swift
//  FanSwift
//
//  Created by 于建祥 on 17/11/3.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices

class HelpViewController: UIViewController {

    @IBOutlet weak var backScrollView: UIScrollView!
    
    @IBOutlet weak var helpView: UIView!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var showImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "帮 助"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = item
        
        self.backScrollView.contentSize = CGSizeMake(kScreenWidth, self.helpView.bounds.height)
        
        //webView的加载方式 但是只动一遍 （可用timer计时刷新，但这种方法太low了）
        let filePath = NSBundle.mainBundle().pathForResource("fanfankan", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        self.webView.loadData(gif!, MIMEType: "image/gif",textEncodingName: String(), baseURL: NSURL())
        self.webView.userInteractionEnabled = false
        
        //正确的打开方式
        showImageAnimation()
    }
    
    func showImageAnimation()
    {
        //        1、将gif图片转为NSData。
        let path = NSBundle.mainBundle().pathForResource("fanfankan", ofType: "gif")
        let data = NSData(contentsOfFile: path!)
        //        2、根据NSData获取CGImageSource对象
        // kCGImageSourceShouldCache : 表示是否在存储的时候就解码
        // kCGImageSourceTypeIdentifierHint : 指明source type
        let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(bool: true), kCGImageSourceTypeIdentifierHint as String: kUTTypeGIF]
        guard let imageSource = CGImageSourceCreateWithData(data!, options) else {
            return
        }
        //        3、获取帧数
        // 获取gif帧数
        let frameCount = CGImageSourceGetCount(imageSource)
        //        4、根据帧数获取每一帧对应的UIImage对象和时间间隔
        var images = [UIImage]()
        var gifDuration = 0.0
        for i in 0 ..< frameCount {
            // 获取对应帧的 CGImage
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, options) else {
                return
            }
            if frameCount == 1 {
                // 单帧
                gifDuration = Double.infinity
            } else{
                // gif 动画
                // 获取到 gif每帧时间间隔
                guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) , gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                    frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else
                {
                    return
                }
                //                print(frameDuration)
                gifDuration += frameDuration.doubleValue
                // 获取帧的img
                let  image = UIImage(CGImage: imageRef , scale: UIScreen.mainScreen().scale , orientation: UIImageOrientation.Up)
                // 添加到数组
                images.append(image)
            }
        }
        //        5、循环播放
        showImageView.contentMode = .ScaleAspectFit
        showImageView.animationImages = images
        showImageView.animationDuration = gifDuration
        showImageView.animationRepeatCount = 0 // 无限循环
        showImageView.startAnimating()
    }
    
    func goBack()
    {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
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
