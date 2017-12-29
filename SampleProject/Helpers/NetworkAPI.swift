//
//  NetworkAPI.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation

// implements endpoint(s)
final class NetworkAPI {
  struct Feed: NetworkRequest {

    typealias Response = NetworkSearchResponse<ObjectFeed>

    var path: String {
      return "/gamejson"
    }

    var parameters: Any? {
      return nil
    }

    var method: HTTPMethod {
      return .get
    }
  }
}
