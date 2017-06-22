//
//  JSONDecodeError.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation

// Return a error if JSON parsing fails
enum JSONDecodeError: Error {
  case invalidFormat
  case missingValue(key: String, actualValue: Any?)
}
