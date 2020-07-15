//
//  RequestAlbumsModel.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class RequestAlbumsModel: RequestModel {
  
  override var path: String {
    return API.albumsEndpoint
  }
  
}
