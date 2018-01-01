//
//  ImageLoader.swift
//  SampleProject
//
//  Created by Kevin Chen on 1/1/18.
//  Copyright © 2018 Kirby. All rights reserved.
//

import Foundation
import UIKit

/// Async load images
class ImageLoader {
  
  static func loadImage(from imagePath: String, completion: @escaping (UIImage?, ImageLoaderError) -> Void) {
    
    guard let url = URL(string: imagePath) else {
      completion(nil, .invalidURL)
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
    
      if error != nil {
        DispatchQueue.main.async {
          completion(nil, .apiFailed(message: "Error with api"))
        }
    
        return
      }
    
      guard let data = data,
        let image = UIImage(data: data) else {
        DispatchQueue.main.async {
          completion(nil, .apiFailed(message: "Data was malformed"))
        }
    
        return
      }
    
      DispatchQueue.main.async {
        completion(image, .noError)
      }
    
    }).resume()
    
  }
}
