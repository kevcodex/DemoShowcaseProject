//
//  NetworkSearchResponse.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation

// The response should return a set of jsondecodable objects
struct NetworkSearchResponse<Item: JSONDecodable>: JSONDecodable {
  let items: [Item]

  init(json: Any) throws {

    guard let array = json as? [Any] else {
      throw JSONDecodeError.invalidFormat
    }

    let items = try array.map { try Item(json: $0) }

    self.items = items
  }
}
