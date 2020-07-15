//
//  PhotosViewModel.swift
//  Swifterviewing
//
//  Created by Muni on 16/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class PhotosViewModel: TableTags {
  
  // MARK: - Properties
  var identifier: String { return "PhotosTableViewCell" }
  var type: Any = PhotosModel()
  fileprivate var realData: PhotosModel?
  var dataArray: [Array<Any>] = [[]]
  
  //MARK: - Methods
  func updateData(data: Any) {
     if data is AlbumsModel {
       realData = data as? PhotosModel
     }
   }
  
  func getPhotos(fromAlbumId index: Int, completionHandler: @escaping(_ status: Bool, _ errorMessage: APIError?) -> Void) {
    NetworkManager.callingRequest(from: RequestPhotosModel(albumId: index)) {  (result: Result<[PhotosModel], APIError>)  in
      switch result {
      case .success(let photoModel):
        // handle success
        self.dataArray = [photoModel]
        completionHandler(true, nil)
      case .failure(let error):
        // handle error
        completionHandler(false, error)
      }
    }
  }
  

}

extension PhotosViewModel: PhotoCellItem {
  // MARK: - Properties
  var albumIdLabel: Int {
    return realData?.albumId ?? 0
  }
  
  var idLabel: Int {
    return realData?.id ?? 0
  }
  
  var titleLabel: String {
    return realData?.title ?? ""
  }
  
  var urlLabel: String {
    return realData?.url ?? ""
  }
  
  var thumbnailUrlLabel: String {
    return realData?.thumbnailUrl ?? ""
  }
  
}
