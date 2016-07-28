//
//  AlertHelper.swift
//  Weather
//
//  Created by George Cavalcanti on 7/28/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessageAlert(title: String, message: String, cancelButton: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        presentViewController(alert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: cancelButton, style: .Cancel) { (action) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
    }
    
}
