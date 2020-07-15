//
//  AlblumsTableViewCell.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

protocol AlbumCellItem {
  var userIdLabel: Int { get }
  var idLabel: Int { get }
  var titleLabel: String { get }
}

class AlblumsTableViewCell: TableCell {
  
  @IBOutlet weak var albumTitleLabel: UILabel!
  
  override func configureCell<T>(t: T) {
    if t is AlbumsViewModel {
      albumTitleLabel.text = (t as! AlbumsViewModel).titleLabel
    }
  }
  
}
