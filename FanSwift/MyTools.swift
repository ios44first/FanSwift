//
//  MyTools.swift
//  FanSwift
//
//  Created by 于建祥 on 17/9/21.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

/* 通常的OC思路 封装成工具类 */
//class MyTools: NSObject
//{
//    static func getScreen_width() -> CGFloat
//    {
//        let width = UIScreen.mainScreen().bounds.size.width
//        return width
//    }
//    
//    static func getScreen_height() -> CGFloat
//    {
//        let height = UIScreen.mainScreen().bounds.size.height
//        return height
//    }
//}


/* swift中是不能使用宏定义语法的，但是因为命名空间的缘故，我们可以给我们的项目添加一个空的Const.swift文件，在其中，我们将原本oc中不需要接受参数的宏，定义成let常量，将需要接受参数的宏定义成函数即可，由于我们的整个项目共享命名空间，我们就可以在项目内的任何地方直接使用Const.swift中定义的这些公共的常量和函数
*/

//屏幕的高、宽
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
let kScreenWidth = UIScreen.mainScreen().bounds.size.width

//根据RGB实例化一个颜色对象
func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

//过关 用时记录 缓存的key
let UD_TIME = "UD_TIME"







