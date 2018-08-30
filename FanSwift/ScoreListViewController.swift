//
//  ScoreListViewController.swift
//  FanSwift
//
//  Created by 于建祥 on 17/10/31.
//  Copyright © 2017年 于建祥. All rights reserved.
//

import UIKit

class ScoreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var tableview :UITableView?
    var arrayData :NSArray?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.title = "成绩排行"

        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = item

        __getDataArray()
        
        tableview = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableview?.delegate = self
        tableview?.dataSource = self
        self.view.addSubview(tableview!)
    }
    
    func __getDataArray()
    {
        let array = NSUserDefaults.standardUserDefaults().valueForKey(UD_TIME) as? NSArray
        if array == nil
        {
            arrayData = []
            return
        }
        arrayData = NSArray(array: array!)
        arrayData = arrayData?.sortedArrayUsingComparator({ (AnyObject1, AnyObject2) -> NSComparisonResult in
            let time1:NSString = AnyObject1.allValues.first as! NSString
            let time2:NSString = AnyObject2.allValues.first as! NSString
            return time1.compare(time2 as String)
        })
    }
    
    func goBack()
    {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*  tableView 代理方法  */

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayData?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "CELL"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil
        {
            cell =  UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        }
        
        let dicTemp = arrayData!.objectAtIndex(indexPath.row)
        let time:String = (dicTemp.allValues.first as? String)!
        cell?.textLabel?.text = NSString(format: "%d："+time+"秒", indexPath.row+1) as String
        cell?.detailTextLabel?.text = dicTemp.allKeys.first as? String
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
