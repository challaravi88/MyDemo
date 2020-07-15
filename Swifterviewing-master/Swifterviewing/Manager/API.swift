//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct API {
   static let baseURL = "https://jsonplaceholder.typicode.com"
   static let photosEndpoint = "/photos" //returns photos and their album ID
   static let albumsEndpoint = "/albums" //returns an album, but without photos
    
}

struct Constant {
  static let incorrectFormate = "The data couldn’t be read because it isn’t in the correct format"
  static let networkMessage = "Please check your internet connection and try again."
}

