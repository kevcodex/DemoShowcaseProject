//
//  JSONDecodable.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation

// A protocol to ensure the data returned is a JSON format
protocol JSONDecodable {
  init(json: Any) throws
}
