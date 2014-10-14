//
//  DetailViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 09.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class DetailViewController: ResponsiveTextFieldViewController, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var items = ["We", "Heart", "Swift", "Roman", "Alona", "Sasha", "Vasia", "Bella", "Shon"]
    
    var nameTitle: String?
    var myDetailImage: String?
    var tik: Int?
    var red = CGFloat()
    var green = CGFloat()
    var blue = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = nameTitle
        //self.postImage.image = UIImage(named: "placeholder.png")
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if tik == 0 {
            //self.postImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            self.postImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        
        //Hello world
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
