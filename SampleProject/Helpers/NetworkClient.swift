//
//  NetworkClient.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
// Handles sending the request

import Foundation

class NetworkClient {
  private let session: URLSession = {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    return session
  }()

  func send<Request: NetworkRequest>(request: Request,
                                    completion: @escaping (Result<Request.Response, NetworkError>) -> Void) {

    guard let urlRequest = request.buildURLRequest() else {
      completion(Result(error: .badRequest(message: "Bad URL Request")))
      return
    }
    
    let task = session.dataTask(with: urlRequest) {
      data, response, error in

      switch (data, response, error) {

        // if an error
      case let (_, _, error?):
        completion(Result(error: .connectionError(error)))

        // if theres data and response
      case let (data?, response?, _):
        do {
          let response = try request.response(from: data, urlResponse: response)
          completion(Result(value: response))
        } catch {
          completion(Result(error: .responseParseError(error)))
        }
      default:
        fatalError("Invalid response combination")
      }
    }
    task.resume()
  }
}
