//
//  NewMessageVC.swift
//  Distress
//
//  Created by Michael Litman on 12/7/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse

class NewMessageVC: UIViewController
{
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var phoneTF: UITextField!

    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createButtonPressed(sender: AnyObject)
    {
        var message = ""
        
        if(self.nameTF.text!.characters.count == 0)
        {
            message = "You must enter a name"
        }
        else if(self.phoneTF.text!.characters.count == 0)
        {
            message = "You must enter a phone number"
        }
        else if(self.messageTV.text!.characters.count == 0)
        {
            message = "You must enter a message"
        }
        
        if(message.characters.count == 0)
        {
            //we can create the Message
            let obj = PFObject(className: "Message")
            obj.setValue(nameTF.text, forKey: "name")
            obj.setValue(phoneTF.text, forKey: "phone")
            obj.setValue(messageTV.text, forKey: "message_text")
            obj.setValue(PhoneCore.currentUser, forKey: "owner_id")
            obj.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if(success)
                {
                    let uhvc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                    self.presentViewController(uhvc, animated: true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else
                {
                    PhoneCore.showAlert("Message Create Error", message: "Something went wrong during save!!!!", presentingViewController: self, onScreenDelay: 2.0)
                }
            })
        }
        else
        {
            //show the error
            PhoneCore.showAlert("Message Create Error", message: message, presentingViewController: self, onScreenDelay: 2.0)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
