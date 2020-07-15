//
//  AlbumsModel.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct AlbumsModel : Codable {
  let userId : Int?
  let id : Int?
  let title : String?

  enum CodingKeys: String, CodingKey {
    case userId = "userId"
    case id = "id"
    case title = "title"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    title = try values.decodeIfPresent(String.self, forKey: .title)
  }
  
  init() {
    userId = 0
    id = 0
    title = ""
  }

}
