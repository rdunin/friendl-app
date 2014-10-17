//
//  DetailViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 09.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class DetailViewController: ResponsiveTextFieldViewController, UITableViewDelegate {
    
    func dispayAlert (title:String, error:String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBOutlet var clike: UILabel!
    @IBOutlet var ccomm: UILabel!
    @IBOutlet var sname: UIButton!
    @IBOutlet var avatar: UIButton!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var BLike: UIButton!
    @IBAction func DLike(sender: AnyObject) {
        
    }
    
    var items = ["We", "Heart", "Swift", "Roman", "Alona", "Sasha", "Vasia", "Bella", "Shon", "Hello", "Petya", "Visi", "Colya", "Gylla"]
    
    var nameTitle: String?
    var counts: Int32?
    var postId: String?
    var myDetailImage: String?
    var tik: Int?
    var red = CGFloat()
    var green = CGFloat()
    var blue = CGFloat()
    
    var comments = [String]()
    var userIds = [String]()
    
    //var hotels = [String: String]()
    //var hotelNames:[String] = []
    
    @IBOutlet var commText: UITextField!
    @IBAction func postButton(sender: AnyObject) {
        
        
        var comm = PFObject(className: "Comment")
        comm["userId"] = PFUser.currentUser().objectId
        comm["postId"] = postId
        comm["posttext"] = commText.text
        
        comm.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
            
            if success == false {
                self.dispayAlert("Can't Post Comment", error: "Please try again latter")
            } else {
                
                self.comments.append(self.commText.text as String)
                self.userIds.append(PFUser.currentUser().objectId as String)
                
                self.tableView.reloadData()
                self.commText.text = ""
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        println(comments.count)
        println(counts)
        
        //hotelNames = [String](hotels.keys)
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Hello world
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        
        if comments.count == -1 {
            
            var messageLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            messageLabel.text = "This post don't have any comment yet. You can be first!"
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.center = CGPointMake(10, 20)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont(name: "Helvetica Neue", size: 22.0)
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
        }
        
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        //var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let comcell:Comcell = tableView.dequeueReusableCellWithIdentifier("ccell") as Comcell
        
        //comcell.comm?.text = self.items[indexPath.row]
        
        comcell.avaImage.layer.cornerRadius = comcell.avaImage.frame.size.width / 2
        comcell.avaImage.clipsToBounds = true
        comcell.avaImage.layer.borderWidth = 1.0
        comcell.avaImage.layer.borderColor = UIColor.blackColor().CGColor
        
        //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        //self.profileImageView.clipsToBounds = YES;
        //self.profileImageView.layer.borderWidth = 3.0f;
        //self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        //let hotelName = hotelNames[indexPath.row]
        
        
        comcell.name.text = userIds[indexPath.row]
        comcell.comm.text = comments[indexPath.row]
        
        return comcell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.titleLabel.text = nameTitle
        //self.postImage.image = UIImage(named: "placeholder.png")
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if tik == 0 {
            //self.postImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            self.postImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        
        var query = PFQuery(className:"Comment")
        query.whereKey("postId", equalTo: postId)
        //query.orderByDescending("createdAt")
        //query.cachePolicy = kPFCachePolicyCacheElseNetwork
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                for object in objects {
                    
                    self.comments.append(object["posttext"] as String)
                    self.userIds.append(object["userId"] as String)
                    
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
        println(comments.count)
        println(counts)
        
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
