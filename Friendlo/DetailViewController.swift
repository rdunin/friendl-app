//
//  DetailViewController.swift
//  Friendlo
//
//  Created by Alona Demochko on 09.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var postImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
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
        
        if tik == 0 {
            //self.postImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            self.postImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        //Hello world
        // Do any additional setup after loading the view.
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
