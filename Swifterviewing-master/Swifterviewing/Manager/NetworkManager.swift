//
//  NetworkManager.swift
//  Swifterviewing
//
//  Created by Muni on 15/07/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

enum APIError: Error {
  case CouldNotReadData
  case NoInternet
  case ServerError
}

enum Result<T, U> where U: Error {
  case success(T)
  case failure(U)
}

struct NetworkManager {
  static func callingRequest<T: Decodable>(from request: RequestModel, completionHandler: @escaping(Result<T, APIError>) -> Void) {
    let dataTask = URLSession.shared.dataTask(with: request.urlRequest()) { (data, urlResponse, error) in
      
      guard error == nil else {
        if let error = error as NSError? {
          if error.code == -1009 {
            completionHandler(.failure(.NoInternet))
          } else {
            completionHandler(.failure(.ServerError))
          }
        }
        return
      }
      
      do {
        let result = try JSONDecoder().decode(T.self, from: data!)
        completionHandler(.success(result))
      } catch {
        completionHandler(.failure(.CouldNotReadData))
      }
      
    }
    dataTask.resume()
  }
  
}
