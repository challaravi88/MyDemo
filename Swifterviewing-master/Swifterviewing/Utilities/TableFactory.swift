//
//  TableFactory.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

final class TableFactory: NSObject {
  
  static let shared = TableFactory()
  
  private override init() { }
  
  fileprivate var vms: [TableTags] = []
  weak var delegate: TableFactoryDataSource?
  
  func registerViewModel(vm: TableTags) -> TableTags {
    
    for viewModel in vms {
      if object_getClassName(viewModel.type) == object_getClassName(vm.identifier) {
        return viewModel
      }
    }
    vms.append(vm)
    return vm
  }
  
}

protocol TableFactoryDataSource: class {
  var dataContainer: [Array<Any>] { get }
}

@objc protocol TableCellDataSource {
  
  var identifier: String { get }
  var type: Any { get }
  @objc optional var rowHeight: CGFloat { get }
  func updateData(data: Any)
}

@objc protocol TableCellDelegate {
  
  @objc optional func didSelectRow(at indexPath: IndexPath)
  @objc optional func willelectRow(at indexPath: IndexPath)
  @objc optional func didDeSelectRow(at indexPath: IndexPath)
  
}

class TableCell: UITableViewCell {
  func configureCell<T>(t: T)  {  }
}

typealias TableTags = TableCellDataSource&TableCellDelegate

extension TableFactory: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let _ = delegate else { return 0 }
    return delegate!.dataContainer.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let _ = delegate else { return 0 }
    guard let d = delegate, d.dataContainer.count > section else { return 0 }
    return d.dataContainer[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    for vm in vms {
      if let del = delegate, indexPath.section < delegate!.dataContainer.count {
        
        let rowItems = del.dataContainer[indexPath.section]
        
        if indexPath.row < rowItems.count {
          
          if object_getClassName(vm.type) == object_getClassName(rowItems[indexPath.row]) {
            
            vm.updateData(data: del.dataContainer[indexPath.section][indexPath.row])
            
            if let _ = tableView.dequeueReusableCell(withIdentifier: vm.identifier) {
              
              let cell = tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath) as! TableCell
              
              // if indexPath.row == se.
              cell.configureCell(t: vm)
              return cell
            }
            
          }
          
        }
      }
    }
    return UITableViewCell()
  }
  
}

extension TableFactory: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    for vm in vms {
      if let del = delegate, indexPath.section < del.dataContainer.count {
        let rowItems = del.dataContainer[indexPath.section]
        if indexPath.row < rowItems.count {
          if object_getClassName(vm.type) == object_getClassName(rowItems[indexPath.row]) {
            vm.didSelectRow?(at: indexPath)
            break
          }
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    for vm in vms {
      if let del = delegate, indexPath.section < del.dataContainer.count {
        let rowItems = del.dataContainer[indexPath.section]
        if indexPath.row < rowItems.count {
          if object_getClassName(vm.type) == object_getClassName(rowItems[indexPath.row]) {
            vm.didDeSelectRow?(at: indexPath)
            break
          }
        }
      }
    }
  }
  
}
