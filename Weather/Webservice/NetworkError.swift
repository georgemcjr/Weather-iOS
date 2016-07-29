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
    
    var description: String {
        
        switch self {
            
        case let .NotFound(statusCode):
            return "URL não encontrada (Erro \(statusCode))"
        case let .Unauthorized(statusCode):
            return "Acesso não autorizado (Erro \(statusCode))"
        case let .ServerError(statusCode):
            return "Ocorreu um erro interno no servidor (Erro \(statusCode))"
        case let .FatalError(errorDescription):
            return "Fatal error: (Erro \(errorDescription))"
        default:
           return "Erro desconhecido"
        }
     
    }
    
    
}
