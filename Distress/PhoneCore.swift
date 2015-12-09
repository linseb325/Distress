//
//  PhoneCore.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/11/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class PhoneCore: NSObject
{
    static var currentUser: PFUser!
    static var theRowData  = [PFObject]()
    
    static func sendSMS(to:String, message: String)
    {
        let parameters = [
            "To": to,
            "From": "+17076825461",
            "Body":message
        ]
        
        Alamofire.request(.POST, "https://api.twilio.com/2010-04-01/Accounts/AC716ff9a9c23fa222caf033ccb359ef49/Messages.json", parameters: parameters, encoding: .URL).authenticate(user: "AC716ff9a9c23fa222caf033ccb359ef49", password: "15610b105792aa2fb1cbd87b8e3b5dd1")

    }
    static func showAlert(title: String, message: String, presentingViewController: UIViewController, onScreenDelay: Double)
    {
        let av = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        presentingViewController.presentViewController(av, animated: true, completion: { () -> Void in
            let delay = onScreenDelay * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                presentingViewController.dismissViewControllerAnimated(true, completion: nil)
            })
        })

    }
}
