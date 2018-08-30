//
//  MyImageView.swift
//  FanSwift
//
//  Created by 于建祥 on 17/10/30.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

class MyImageView: UIImageView
{
    var fruit : UIImage?  //蔬菜图片
    var flag : Int?      //用于对比的标记
    
    func turnLeft() //图片左翻，从问号翻到蔬菜
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self, cache: true)
        self.image = self.fruit
        UIView.commitAnimations()
        self.userInteractionEnabled = false
        
//        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {
//            
//            self.image = self.fruit
//            
//            }, completion: { (finish) in
//                
//                self.userInteractionEnabled = false
//                
//        })
    }
    
    func turnRight() //图片右翻，从蔬菜翻到问号
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: self, cache: true)
        self.image = UIImage(named: "contrary.png")
        UIView.commitAnimations()
        self.userInteractionEnabled = true
        
//        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: {
//            
//            self.image = UIImage(named: "contrary.png")
//            
//        }) { (finish) in
//            
//            self.userInteractionEnabled = true
//            
//        }
    }
    
    
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
