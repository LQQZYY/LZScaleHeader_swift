//
//  ViewController.swift
//  LZScaleHeader
//
//  Created by Artron_LQQ on 16/8/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let table = UITableView(frame: self.view.bounds, style: .Plain)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        table.headerHeight = 100
//        table.addScaleHeaderWithImage(UIImage(named: "40fe711f9b754b596159f3a6.jpg")!)
        
        let label = UILabel()
        label.text = "这是一个label"
        
        //一句代码添加头视图
        table.addScaleHeaderView(UIImage(named: "40fe711f9b754b596159f3a6.jpg")!, coverView: label)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellID")
        
        if cell == nil {
            cell = UITableViewCell(style: .Default,reuseIdentifier: "cellID")
        }
        
        cell?.textLabel?.text = "\(indexPath.section)--\(indexPath.row)"
        return cell!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

