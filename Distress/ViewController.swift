//
//  ViewController.swift
//  Distress
//
//  Created by Michael Litman on 12/4/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var count = 0
    
    @IBOutlet weak var theCV: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className: "Message")
        query.whereKey("owner_id", equalTo: PhoneCore.currentUser)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if(objects != nil)
            {
                self.count = objects!.count
                PhoneCore.theRowData = objects!
                print("found \(self.count) items in if statement")
                self.theCV.reloadData()
            }
            else
            {
                self.count = 0
            }
        }

        print("found \(self.count) objects in viewDidLoad")
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of items
        print("about to return \(self.count) items")
        return self.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.theCV.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCVCell
        print("configuring cell")
        // Configure the cell
        cell.backgroundColor = UIColor.redColor()
        cell.theLabel.textColor = UIColor.whiteColor()
        cell.theLabel.text = String(PhoneCore.theRowData[indexPath.row]["name"])
        //cell.theLabel.text = "blah"
        return cell
    }
    
    //Collection view was tapped
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        PhoneCore.sendSMS("9207238101", message: "\(PhoneCore.theRowData[indexPath.row]["message_text"])")
        print("Message sent: \(PhoneCore.theRowData[indexPath.row]["message_text"])")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }


}

