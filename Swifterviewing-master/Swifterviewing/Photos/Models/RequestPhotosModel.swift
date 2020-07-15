//
//  RequestPhotosModel.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class RequestPhotosModel: RequestModel {
  
  let albumId: Int
  
  override var path: String {
    return API.photosEndpoint
  }
  
  override var parameters: [String : Any] {
    return ["albumId": albumId]
  }
  
  init(albumId: Int) {
    self.albumId = albumId
  }
  
}
