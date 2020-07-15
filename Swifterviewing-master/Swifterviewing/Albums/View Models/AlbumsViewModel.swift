//
//  AlbumsViewModel.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class AlbumsViewModel: TableTags {
  
  // MARK: - Properties

  var identifier: String { return "AlblumsTableViewCell" }
  var type: Any = AlbumsModel()
  fileprivate var realData: AlbumsModel?
  var dataArray: [Array<Any>] = [[]]
  
  //MARK: - Methods
  func updateData(data: Any) {
     if data is AlbumsModel {
       realData = data as? AlbumsModel
     }
   }
  
  func getAlbums(_ completionHandler: @escaping(_ status: Bool, _ errorMessage: APIError?) -> Void) {
    NetworkManager.callingRequest(from: RequestAlbumsModel()) {  (result: Result<[AlbumsModel], APIError>)  in
      switch result {
      case .success(let albumModel):
        // handle success
        self.dataArray = [albumModel]
        completionHandler(true, nil)
      case .failure(let error):
        // handle error
        completionHandler(false, error)
      }
      
    }
  }
  

}

extension AlbumsViewModel: AlbumCellItem {
  // MARK: - Properties
  var userIdLabel: Int {
    return realData?.userId ?? 0
  }
  
  var idLabel: Int {
    return realData?.id ?? 0
  }
  
  var titleLabel: String {
    var albumNameString = realData?.title ?? ""
    albumNameString = albumNameString.replacingOccurrences(of: "e", with: "")
    return albumNameString
  }
  
}
