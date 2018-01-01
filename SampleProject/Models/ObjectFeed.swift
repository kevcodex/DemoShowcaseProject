//
//  ObjectFeed.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation
import UIKit

// The object that is recieved
struct ObjectFeed: JSONDecodable {
    
  private static let dateFormatter = DateFormatter()

  let description: String
  let name: String
  let imagePath: String?
  let rawDate: String
  let developer: String


  var firstSentence: String {
    let seperators = CharacterSet(charactersIn: ".!?")

    return description.components(separatedBy: seperators).first ?? ""
  }

  var readableDate: String {
    ObjectFeed.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    ObjectFeed.dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    let date = ObjectFeed.dateFormatter.date(from: rawDate) ?? Date()

    ObjectFeed.dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
    ObjectFeed.dateFormatter.amSymbol = "AM"
    ObjectFeed.dateFormatter.pmSymbol = "PM"
    ObjectFeed.dateFormatter.timeZone = NSTimeZone.local

    let string = ObjectFeed.dateFormatter.string(from: date)

    return string
  }

  init(json: Any) throws {
    guard let dictionary = json as? [String: Any] else {
      throw JSONDecodeError.invalidFormat
    }

    guard let description = dictionary["description"] as? String else {
      throw JSONDecodeError.missingValue(key: "description", actualValue: dictionary["description"])
    }

    guard let name = dictionary["name"] as? String else {
      throw JSONDecodeError.missingValue(key: "name", actualValue: dictionary["name"])
    }
    guard let imagePath = dictionary["image"] else {
      throw JSONDecodeError.missingValue(key: "image", actualValue: dictionary["image"])
    }
    guard let rawDate = dictionary["date"] as? String else {
      throw JSONDecodeError.missingValue(key: "date", actualValue: dictionary["date"])
    }
    guard let developer = dictionary["developer"] as? String else {
      throw JSONDecodeError.missingValue(key: "developer", actualValue: dictionary["developer"])
    }

    self.description = description
    self.name = name
    self.rawDate = rawDate
    self.developer = developer
    self.imagePath = imagePath as? String ?? nil
  }
}
