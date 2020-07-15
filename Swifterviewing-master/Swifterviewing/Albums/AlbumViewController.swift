//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
  
  //MARK: - Properties
  @IBOutlet weak var listTableView: UITableView!
  private let segueAlbumDetailsView = "SegueAlbumDetailsView"
  var viewModel: AlbumsViewModel = AlbumsViewModel()
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  //MARK: - View Life Cycle
  func setupUI() {
    
    self.title = "Albums"
    
    TableFactory.shared.delegate = self
    listTableView.dataSource = TableFactory.shared
    listTableView.delegate = TableFactory.shared
    let _ = TableFactory.shared.registerViewModel(vm: AlbumsViewModel()) as! AlbumsViewModel
    
    //Get albums
    viewModel.getAlbums { [weak self](status, error) in
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
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let _ = listTableView.indexPathForSelectedRow else { return }
    
    if let _ = segue.destination as? PhotosViewController {
      //target.albumModel = dataArray[selectedPath.section][selectedPath.row] as?
    } else {
      fatalError("Unexpected Destination View Controller")
    }
  }
  
  
}

//MARK: - Properties
extension AlbumViewController: TableFactoryDataSource {
  var dataContainer: [Array<Any>] {
    return viewModel.dataArray
  }
}

extension AlbumViewController: TableCellDelegate {
  func didSelectRow(at indexPath: IndexPath) {
    
  }
}
