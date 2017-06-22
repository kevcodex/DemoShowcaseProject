//
//  ObjectFeed.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import Foundation
import UIKit

//the object that is recieved
struct ObjectFeed: JSONDecodable {
  let id: Int
  let description: String
  let title: String
  let imagePath: String?
  let rawDate: String
  let developer: String

  var image: UIImage?

  var firstSentence: String {
    let seperators = CharacterSet(charactersIn: ".!?")

    return description.components(separatedBy: seperators).first ?? ""
  }

  var readableDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    let date = dateFormatter.date(from: rawDate)!

    dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    dateFormatter.timeZone = NSTimeZone.local

    let string = dateFormatter.string(from: date)

    return string
  }

  init(json: Any) throws {
    guard let dictionary = json as? [String: Any] else {
      throw JSONDecodeError.invalidFormat
    }
    guard let id = dictionary["id"] as? Int else {
      throw JSONDecodeError.missingValue(key: "id", actualValue: dictionary["id"])
    }

    guard let description = dictionary["description"] as? String else {
      throw JSONDecodeError.missingValue(key: "description", actualValue: dictionary["description"])
    }

    guard let title = dictionary["title"] as? String else {
      throw JSONDecodeError.missingValue(key: "title", actualValue: dictionary["title"])
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

    self.id = id
    self.description = description
    self.title = title
    self.rawDate = rawDate
    self.developer = developer
    self.imagePath = imagePath as? String ?? nil

    // probably better to cache the images due to large size
    if let imagePath = self.imagePath,
      let url = URL(string: imagePath),
      let data = try? Data(contentsOf: url),
      let image = UIImage(data: data),
      let compressedImageData = UIImageJPEGRepresentation(image, 0.0) {

      self.image = UIImage(data: compressedImageData) ?? nil

    } else {
      image = UIImage(named: "PlaceHolder") ?? nil
    }
  }
}
