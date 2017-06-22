//
//  ActivityViewPresentor.swift
//  SampleProject
//
//  Created by Kirby on 6/20/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

/// Used for view controllers that need to present an activity indicator
protocol ActivityIndicatorPresentor {

  var activityIndicator: ActivityProgressHud { get }

  func showActivityIndicator(title: String)

  func hideActivityIndicator()
}

extension ActivityIndicatorPresentor where Self: UIViewController {

  func showActivityIndicator(title: String) {

    DispatchQueue.main.async {

      // prevents another progress hud from appearing if it already exists
      if self.isActivityIndicatorPresent {
        return
      }

      self.activityIndicator.text = title
      self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 85, height: 85)
      self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
      self.view.addSubview(self.activityIndicator)
    }
  }

  func hideActivityIndicator() {
    DispatchQueue.main.async {

      self.activityIndicator.removeFromSuperview()
    }
  }

  /// Checks to see if a activity indicator is already presented in the view
  private var isActivityIndicatorPresent: Bool {

    let allActivityIndicators = view.subviews.flatMap { $0 as? ActivityProgressHud }
    return (allActivityIndicators.count >= 1 ? true : false)
  }
}
