//
//  PhotosTableViewCell.swift
//  Swifterviewing
//
//  Created by Muni on 16/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

protocol PhotoCellItem {
  var albumIdLabel: Int { get }
  var idLabel: Int { get }
  var titleLabel: String { get }
  var urlLabel: String { get }
  var thumbnailUrlLabel: String { get }

}

class PhotosTableViewCell: TableCell {
  
  @IBOutlet weak var photoTitleLabel: UILabel!
  @IBOutlet weak var thumbImageView: UIImageView!

  override func configureCell<T>(t: T) {
    if t is PhotosViewModel {
      photoTitleLabel.text = (t as! PhotosViewModel).titleLabel
    }
  }
  
}
