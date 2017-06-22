//
//  Result.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation

// A generic result for success or failure
enum Result<T, Error: Swift.Error> {
  case success(T)
  case failure(Error)

  init(value: T) {
    self = .success(value)
  }

  init(error: Error) {
    self = .failure(error)
  }
}
