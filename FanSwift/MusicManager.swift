//
//  MusicManager.swift
//  FanSwift
//
//  Created by 于建祥 on 17/10/30.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit
import AVFoundation

class MusicManager: NSObject, UIAlertViewDelegate
{
    var bgPlayer: AVAudioPlayer!  //背景音乐
    var clickPlayer: AVAudioPlayer!  //点击声音
    var rightPlayer: AVAudioPlayer!  //翻对声音
    
    static let shareInstance = MusicManager()
    
    //This prevents others from using the default '()' initializer for this class.
    private override init()
    {
        super.init()
        self.loadBackGroudMusic()
        self.loadClickMusic()
        self.loadRightMusic()
    }
    
    //初始化音频
    private func loadBackGroudMusic()
    {
        let path = NSBundle.mainBundle().pathForResource("sound_bg", ofType: "mp3")
        let url = NSURL.fileURLWithPath(path!)
        do
        {
            try bgPlayer = AVAudioPlayer.init(contentsOfURL: url)
        }
        catch
        {
            let alertView = UIAlertView.init(title: "Error", message:"背景音频初始化失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再来一次")
            alertView.tag = 100
            alertView.show()
        }
        bgPlayer.prepareToPlay()
    }
    
    private func loadClickMusic()
    {
        let path = NSBundle.mainBundle().pathForResource("fan", ofType: "mp3")
        let url = NSURL.fileURLWithPath(path!)
        do
        {
            try clickPlayer = AVAudioPlayer.init(contentsOfURL: url)
        }
        catch
        {
            let alertView = UIAlertView.init(title: "Error", message:"点击音频初始化失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再来一次")
            alertView.tag = 200
            alertView.show()
        }
        clickPlayer.prepareToPlay()
    }

    private func loadRightMusic()
    {
        let path = NSBundle.mainBundle().pathForResource("success", ofType: "mp3")
        let url = NSURL.fileURLWithPath(path!)
        do
        {
            try rightPlayer = AVAudioPlayer.init(contentsOfURL: url)
        }
        catch
        {
            let alertView = UIAlertView.init(title: "Error", message:"翻成功音频初始化失败", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "再来一次")
            alertView.tag = 300
            alertView.show()
        }
        rightPlayer.prepareToPlay()
    }

    //对外的 播放音频接口
    static func playBackGroudMusic()
    {
        shareInstance.bgPlayer.volume = 0.6
        shareInstance.bgPlayer.play()
    }
    
    static func playClickMusic()
    {
        shareInstance.clickPlayer.volume = 0.6
        shareInstance.clickPlayer.play()
    }
    
    static func playRightMusic()
    {
        shareInstance.rightPlayer.volume = 0.6
        shareInstance.rightPlayer.play()
    }
    
    static func stopBackGroudMusic()
    {
        shareInstance.bgPlayer.stop()
    }
    
    static func isplayingBackGroudMusic() -> Bool
    {
        return shareInstance.bgPlayer.playing
    }
    
    
    //alert弹框协议
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex != alertView.cancelButtonIndex
        {
            if alertView.tag == 100
            {
                self.loadBackGroudMusic()
            }
            else if alertView.tag == 200
            {
                self.loadClickMusic()
            }
            else if alertView.tag == 300
            {
                self.loadRightMusic()
            }
        }
    }
}
