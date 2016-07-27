//
//  NetworkError.swift
//  Weather
//
//  Created by George Cavalcanti on 7/26/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import Foundation

enum NetworkError : ErrorType {
    
    case NotFound(Int)
    case Unauthorized(Int)
    case ServerError(Int)
    case FatalError(String)
    case Unknown
    
    
}
