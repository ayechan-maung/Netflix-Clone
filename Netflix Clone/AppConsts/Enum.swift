//
//  Enum.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 14/03/2023.
//

import Foundation


enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}
