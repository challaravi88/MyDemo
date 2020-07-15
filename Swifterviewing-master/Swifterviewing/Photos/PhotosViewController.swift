//
//  PhotosViewController.swift
//  Swifterviewing
//
//  Created by Muni on 16/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  
  //MARK: - Properties
  @IBOutlet weak var listTableView: UITableView!
  var viewModel: PhotosViewModel = PhotosViewModel()
  var albumModel: AlbumsModel!
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  //MARK: - View Life Cycle
  func setupUI() {
    
    self.title = albumModel.title
    
    TableFactory.shared.delegate = self
    let _ = TableFactory.shared.registerViewModel(vm: PhotosViewModel()) as! AlbumsViewModel
    listTableView.dataSource = TableFactory.shared
    listTableView.delegate = TableFactory.shared
    
    //Get albums
    viewModel.getPhotos(fromAlbumId: albumModel.id!, completionHandler: { [weak self](status, error) in
      DispatchQueue.main.async {
        guard error == nil else {
          switch error {
          case .CouldNotReadData:
            print(Constant.incorrectFormate)
          case .NoInternet:
            print(Constant.networkMessage)
          case .ServerError:
            print(": Error")
          case .none:
            print("none")
          }
          return
        }
        
        if status {
          self?.listTableView.reloadData()
        }
      }
    })
  }
  
}

//MARK: - Properties
extension PhotosViewController: TableFactoryDataSource {
  var dataContainer: [Array<Any>] {
    return viewModel.dataArray
  }
  
}
