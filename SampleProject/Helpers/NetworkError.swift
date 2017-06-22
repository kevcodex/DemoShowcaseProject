//
//  NetworkError.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.

import Foundation

// enum for a response error
enum NetworkError: Error {

  case connectionError(Error)

  case responseParseError(Error)
}
