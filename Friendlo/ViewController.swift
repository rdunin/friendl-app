//
//  ViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 03.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func dispayAlert (title:String, error:String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func fblogin(sender: AnyObject) {
        
        var permissions = ["public_profile","email","user_friends"]
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
                
                self.dispayAlert("Please aprove Facebook login", error: "")
                
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                
                var userQuery = PFUser.query()
                userQuery.getObjectInBackgroundWithId(PFUser.currentUser().objectId) {
                    (userObject: PFObject!, error: NSError!) -> Void in
                    
                    var fbRequest = FBRequest.requestForMe()
                    fbRequest.startWithCompletionHandler { (connection: FBRequestConnection!, result:AnyObject!, error: NSError!) in
                        
                        if error == nil {
                            
                            //FACEBOOK DATA IN DICTIONARY
                            var userData = result as NSDictionary
                            var faceBookId = userData.objectForKey("id") as NSString
                            var faceBookEmail = userData.objectForKey("email") as NSString
                            var faceBookName = userData.objectForKey("name") as NSString
                            var faceBookFname = userData.objectForKey("first_name") as NSString
                            var faceBookLname = userData.objectForKey("last_name") as NSString
                            var faceBookGender = userData.objectForKey("gender") as NSString
                            var faceBookLocale = userData.objectForKey("locale") as NSString
                            
                            var url:NSURL = NSURL.URLWithString(NSString(format:"https://graph.facebook.com/%@/picture?width=50", faceBookId))
                            var err: NSError?
                            var imageData :NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
                            var imageFile = PFFile(name: "image.jpg", data: imageData) as PFFile
                            
                            //println(userData)
                            
                            userObject.setObject(faceBookId, forKey: "fbid")
                            userObject.setObject(faceBookEmail, forKey: "email")
                            userObject.setObject(faceBookName, forKey: "username")
                            userObject.setObject(faceBookFname, forKey: "first_name")
                            userObject.setObject(faceBookLname, forKey: "last_name")
                            userObject.setObject(imageFile, forKey: "picture")
                            userObject.setObject(faceBookGender, forKey: "gender")
                            userObject.setObject(faceBookLocale, forKey: "locale")
                            
                            userObject.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                                if success == true {
                                    self.performSegueWithIdentifier("userFeed", sender: self)
                                } else{
                                    self.dispayAlert("Please try again later!", error: "")
                                }
                            }
                            
                            //userObject.saveInBackground()
                            
                            
                        }
                    }
                    
                }
                
                //self.performSegueWithIdentifier("userFeed", sender: self)
            } else {
                NSLog("User logged in through Facebook!")
                self.performSegueWithIdentifier("userFeed", sender: self)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if Connect.isConnectedToNetwork() {
            if PFUser.currentUser() != nil {
                self.performSegueWithIdentifier("userFeed", sender: self)
            }
        } else {
            println("Not connected to internet")
            self.performSegueWithIdentifier("Checknet", sender: self)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }


}

