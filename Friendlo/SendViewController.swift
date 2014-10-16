//
//  SendViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 05.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func dispayAlert (title:String, error:String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var titleText: UITextView!
    
    var photoSelected:Bool = false
    
    @IBAction func photoGet(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func pictureGet(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        println("Image Selectd")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        postImage.image = image
        photoSelected = true
    }
    
    @IBAction func bgsStyle(sender: AnyObject) {
        postImage.backgroundColor = getRandomColor()
    }
    
    
    @IBAction func sendPost(sender: AnyObject) {
        
        var error = ""
        
        if (titleText.text == "" || titleText.text == "Question or needs...") {
            error = "Please enter a message"
        }
        
        if (error != ""){
            dispayAlert("Can't Send Post", error: error)
        } else {
        
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var post = PFObject(className: "Post")
            post["title"] = titleText.text
            post["username"] = PFUser.currentUser().username
            post["userId"] = PFUser.currentUser().objectId
            
            post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                if success == false {
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.dispayAlert("Can't Post Image", error: "Please try again latter")
                }else{
                    
                    if self.photoSelected == true {
                    
                    let imageData = UIImagePNGRepresentation(self.postImage.image)
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    post["imagefile"] = imageFile
                    post["pic"] = 1
                    
                    post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            self.dispayAlert("Can't Post Image", error: "Please try again latter")
                        }else{
                            //self.dispayAlert("Your Post is posted", error: "It's OK")
                            self.performSegueWithIdentifier("savefeed", sender: self)
                            //self.photoSelected = 0
                            //self.postImage.image = UIImage(named: "")
                            //self.titleText.text = "Question or needs..."
                            
                            //println("posted sucessful")
                            
                            }
                     }
                 
                    }else{
                        
                        var uicolor = self.postImage.backgroundColor?.CGColor
                        var components = CGColorGetComponents(uicolor);
                
                        post["color"] = [ components[0], components[1], components[2] ]
                        post["pic"] = 0
                        
                        post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                            
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            
                            if success == false {
                                self.dispayAlert("Can't Post Image", error: "Please try again latter")
                                
                            }else{
                                //self.dispayAlert("Your Post is posted", error: "It's OK")
                                self.performSegueWithIdentifier("savefeed", sender: self)
                                
                                //self.photoSelected = 0
                                //self.postImage.image = UIImage(named: "")
                                //self.titleText.text = "Question or needs..."
                                
                                //println("posted sucessful")
                                
                            }
                        }
                        
                    }
                
                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.setNeedsStatusBarAppearanceUpdate()
        
        photoSelected = 0
        titleText!.delegate = self
        //desctext.text = ""
        //descrText.backgroundColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1)
        //postImage.backgroundColor = UIColor(red: 103.0/255.0, green: 128.0/255.0, blue: 159.0/255.0, alpha: 1)
        postImage.backgroundColor = getRandomColor()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        println("START DESC2")
        if textView.text == "Question or needs..."{
            textView.text = ""
        }
    }
    
    func displayColors(){
        
        var cred:CGFloat = 93.0
        var cblue:CGFloat = 127.0
        var cgreen:CGFloat = 238.0
        var calpha:CGFloat = 1.0
        
        var uicolor = UIColor(red: cred/255.0, green: cgreen/255.0, blue: cblue/255.0, alpha: calpha)
        var numComponents = CGColorGetNumberOfComponents(uicolor.CGColor)
        
        if (numComponents == 4)
        {
            let components = CGColorGetComponents(uicolor.CGColor);
            cred = components[0];
            cgreen = components[1];
            cblue = components[2];
            calpha = components[3];
            
            println("\(cred) \(cgreen) \(cblue) \(calpha)")
        }
    }
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
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
