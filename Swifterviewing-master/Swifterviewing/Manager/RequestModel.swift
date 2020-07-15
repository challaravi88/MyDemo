//
//  RequestModel.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

enum  HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
}

class RequestModel {
  
  //MARK: - Properties
  var path: String {
    return ""
  }
  
  var parameters: [String: Any] {
    return [:]
  }
  
  var headers: [String: String] {
    return ["Content-Type": "application/json"]
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var body: [String: Any] {
    return [:]
  }
  
}

//MARK: - Public Functions
extension RequestModel {
  
  func urlRequest() -> URLRequest {
    
    var endPoint: String = API.baseURL.appending(path)
    
    for (key, value) in parameters {
       endPoint.append("?\(key)=\(value)")
    }
    
    var request: URLRequest = URLRequest(url: URL(string: endPoint)!)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers
    
    if method == .post {
      
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
      } catch let error {
        print("Request body parse error: \(error.localizedDescription)")
      }
      
    }
    
    return request
  }
  
  
}
