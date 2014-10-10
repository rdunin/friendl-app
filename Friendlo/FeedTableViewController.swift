//
//  FeedTableViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 04.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, FBLoginViewDelegate {

    var profilePictureView:FBProfilePictureView = FBProfilePictureView()
    var fbloginView:FBLoginView = FBLoginView()
    
    var pic = [Int]()
    var titles = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var imageFiles = [PFFile]()
    
    var red = [CGFloat]()
    var green = [CGFloat]()
    var blue = [CGFloat]()
    
    @IBOutlet var toogleName: UISegmentedControl!
    @IBAction func toogleFeed(sender: AnyObject) {
      
        switch sender.selectedSegmentIndex {
        case 0:
            println("first segement clicked")
        case 1:
            println("second segment clicked")
        default:
            break;
        }
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gets()
        
        var query = PFQuery(className:"Post")
        //query.whereKey("username", equalTo: PFUser.currentUser().username)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    
                    self.pic.append(object["pic"] as Int)
                    self.titles.append(object["title"] as String)
                    if object["pic"] as Int == 1 {
                        self.imageFiles.append(object["imagefile"] as PFFile)
                        
                        self.red += [0.0]
                        self.green += [0.0]
                        self.blue += [0.0]
                        
                    } else {
                        var cols = object["color"] as Array<CGFloat>
                        
                        self.red.append(cols[0] as CGFloat)
                        self.green.append(cols[1] as CGFloat)
                        self.blue.append(cols[2] as CGFloat)
                        
                        
                        var image = UIImage(named: "placeholder.png")
                        var imageData = UIImagePNGRepresentation(image)
                        let imageFile = PFFile(name: "image.png", data: imageData)
                        //self.imageFiles += imageFile!
                        //var imageFile = PFFile(name: "image.png", contentsAtPath: "logo.png")
                        
                        self.imageFiles.append(imageFile as PFFile)
                        
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println(error)
            }
        }
        
        //self.setNeedsStatusBarAppearanceUpdate()
        //fbloginView.readPermissions = ["email", "basic_info"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return titles.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 320
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell:Cell = tableView.dequeueReusableCellWithIdentifier("myCell") as Cell
        
        
        
        myCell.titleTexts.text = titles[indexPath.row]
        
        if pic[indexPath.row] == 1 {
        
            imageFiles[indexPath.row].getDataInBackgroundWithBlock{
                (imageData: NSData!, error: NSError!) -> Void in
            
                if error == nil {
                    let image = UIImage(data: imageData)
                
                    myCell.titleImage.image = image
                }
            
            }
            
            
        } else {
        
            println(red)
            println(imageFiles)
            
            myCell.titleImage.backgroundColor = UIColor(red: red[indexPath.row], green: green[indexPath.row], blue: blue[indexPath.row], alpha: 1.0)
            
            var bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: red[indexPath.row], green: green[indexPath.row], blue: blue[indexPath.row], alpha: 1.0)
            myCell.selectedBackgroundView = bgColorView
            
            myCell.shadow.backgroundColor = UIColor(red: red[indexPath.row], green: green[indexPath.row], blue: blue[indexPath.row], alpha: 0.0)
            
        }
    
        return myCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var detailedViewController: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
        
        detailedViewController.nameTitle = titles[indexPath.row]
        
        self.presentViewController(detailedViewController, animated: true, completion: nil)
        
    }
    
    /*
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    
    
    override func prepareForSegue(_ segue: UIStoryboardSegue, sender : AnyObject?) {
        let path = self.tableView.indexPathForSelectedRow()!
        let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
    
        segue.destinationViewController.detail = self.detailForIndexPath(path)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailView"
        {
        //let indexPath = tvCars.indexPathForSelectedRow().row+1
        //((segue.destinationViewController) as DetailViewController).index=indexPath
        }
    }
    
    
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func gets() {
        
        
        //PFFacebookUtils.initializeFacebook()
        
                
                var userQuery = PFUser.query()
                    userQuery.getObjectInBackgroundWithId(PFUser.currentUser().objectId) {
                        (userObject: PFObject!, error: NSError!) -> Void in
                        
                        var completionHandler = {
                            connection, result, error in
                            
                            //println(result)
                            
                            } as FBRequestHandler;
                        
                        var resu = FBRequestConnection.startWithGraphPath("me", completionHandler: completionHandler)
                        
                        var fbRequest = FBRequest.requestForMe()
                        
                        fbRequest.startWithCompletionHandler { (connection: FBRequestConnection!, result:AnyObject!, error: NSError!) in
                            
                            if error == nil {
                                
                                //FACEBOOK DATA IN DICTIONARY
                                var userData = result as NSDictionary
                                //var faceBookId = userData.objectForKey("id") as NSString
                                //var faceBookName = userData.objectForKey("first_name") as NSString
                                //var faceBookMiddle = userData.objectForKey("middle_name") as NSString
                                //var faceBookGender = userData.objectForKey("gender") as NSString
                                
                                //var url:NSURL = NSURL.URLWithString(NSString(format:"https://graph.facebook.com/%@/picture?width=320", faceBookId))
                                //var err: NSError?
                                //var imageData :NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
                                
                                //var imageFile = PFFile(name: "image.jpg", data: imageData) as PFFile
                                
                                println(userData)
                                
                                //userObject.setObject(faceBookName, forKey: "name")
                                //userObject.setObject(imageFile, forKey: "file")
                                //userObject.setObject(faceBookGender, forKey: "gender")
                                
                                //userObject.saveInBackground()
                                
                                
                            }
                        }
                        
                    }
            
            
        
    }

}
