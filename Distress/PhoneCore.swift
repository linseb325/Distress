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
    static var theRowData = [PFObject]()
    
    static func sendSMS(to:String, message: String)
    {
        let parameters = [
            "To": to,
            "From": "+19205426123",
            "Body": message
        ]
        
        Alamofire.request(.POST, "https://api.twilio.com/2010-04-01/Accounts/ACb30052be71699f3eaf75976981957117/Messages.json", parameters: parameters, encoding: .URL).authenticate(user: "ACb30052be71699f3eaf75976981957117", password: "1a57be7321501f48fa36251b734584ac")

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
