//
//  ErrorMessage.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import Foundation

enum DUError: String, Error {
    case invalidUsername    = "This username created an invalid request. Pealse try agin."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data erceived from the server was invalid. Please try again."
}
