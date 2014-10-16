//
//  DetailViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 09.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class DetailViewController: ResponsiveTextFieldViewController, UITableViewDelegate {

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
    
    @IBOutlet var commText: UITextField!
    @IBAction func postButton(sender: AnyObject) {
        println(commText.text)
        tableView.reloadData()
        commText.text = ""
    }
    
    var items = ["We", "Heart", "Swift", "Roman", "Alona", "Sasha", "Vasia", "Bella", "Shon", "Hello", "Petya", "Visi", "Colya", "Gylla"]
    
    var hotels:[String: String] = ["The Grand Del Mar": "5300 Grand Del Mar Court, San Diego, CA 92130 5300 Grand Del Mar Court",
        "French Quarter Inn": "166 Church St, Charleston, SC 29401 5300 Grand Del Mar Court",
        "Bardessono": "6526 Yount Street, Yountville, CA 94599",
        "Hotel Yountville": "6462 Washington Street, Yountville, CA 94599",
        "Islington Hotel": "321 Davey Street, Hobart, Tasmania 7000, Australia",
        "The Henry Jones Art Hotel": "25 Hunter Street, Hobart, Tasmania 7000, Australia",
        "Clarion Hotel City Park Grand": "22 Tamar Street, Launceston, Tasmania 7250, Australia",
        "Quality Hotel Colonial Launceston": "31 Elizabeth St, Launceston, Tasmania 7250, Australia",
        "Premier Inn Swansea Waterfront": "Waterfront Development, Langdon Rd, Swansea SA1 8PL, Wales",
        "Hatcher's Manor": "73 Prossers Road, Richmond, Clarence, Tasmania 7025, Australia"]
    
    var hotelNames:[String] = []
    
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
        
        hotelNames = [String](hotels.keys)
        
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
        return hotels.count
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

        
        
        let hotelName = hotelNames[indexPath.row]
        comcell.name.text = hotelName
        comcell.comm.text = hotels[hotelName]
        
        return comcell
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
