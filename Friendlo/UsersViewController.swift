//
//  UsersViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 16.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    var usernam = String()
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var uname: UILabel!
    var fbid = String()
    
    @IBAction func facelink(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/app_scoped_user_id/\(fbid)"))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 1.0
        avatar.layer.borderColor = UIColor.whiteColor().CGColor
        
        var poster = PFUser.query()
        poster.whereKey("username", equalTo: usernam)
        poster.findObjectsInBackgroundWithBlock {
            (users: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                for use in users {
                    var nam: String = (use["first_name"] as String) + " " + (use["last_name"] as String)
                    self.uname.text = nam
                    self.fbid = use["fbid"] as String
                    //self.avatar.append(object["picture"] as PFFile)
                    //detailedViewController.sname.setTitle(nam, forState: UIControlState.Normal)
                    
                    let userImageFile = use["picture"] as PFFile
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            self.avatar.image = UIImage(data:imageData)
                            //avatar.setImage(image, forState: UIControlState.Normal)
                        }
                    }
                    
                }
            }
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
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
