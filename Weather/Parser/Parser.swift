//
//  Parser.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parse(data: NSData) -> [String:AnyObject]? {
        
        do {
            if let result = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                as? [String:AnyObject] {
                return result
            } else {
                print("Data could not be serialized.")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
}
