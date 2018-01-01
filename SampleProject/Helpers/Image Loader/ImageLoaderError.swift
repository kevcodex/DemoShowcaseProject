//
//  ImageLoaderError.swift
//  SampleProject
//
//  Created by Kevin Chen on 1/1/18.
//  Copyright © 2018 Kirby. All rights reserved.
//

import Foundation

enum ImageLoaderError: Error {
  case noError
  case invalidURL
  case apiFailed(message: String)
}

extension ImageLoaderError: Equatable {
  static func ==(lhs: ImageLoaderError, rhs: ImageLoaderError) -> Bool {
    switch (lhs, rhs) {
      
    case (.noError, .noError):
      return true
      
    case (.invalidURL, .invalidURL):
      return true
      
    case (let .apiFailed(errorMessage1), let .apiFailed(errorMessage2)):
      return errorMessage1 == errorMessage2
      
    default:
      return false
    }
  }
  
}
