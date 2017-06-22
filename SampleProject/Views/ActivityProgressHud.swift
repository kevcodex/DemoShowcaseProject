//
//  ActivityProgressHud.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

/// A custom view to present an activity indicator with text and blurred background
@IBDesignable class ActivityProgressHud: UIView {

  @IBInspectable var text: String {
    didSet {
      label.text = text
    }
  }

  @IBInspectable var textColor: UIColor = .white {
    didSet {
      label.textColor = textColor
    }
  }

  let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
  let label = UILabel()
  let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
  var vibrancyView: UIVisualEffectView

  init() {
    text = ""
    vibrancyView = UIVisualEffectView(effect: blurEffect)
    super.init(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    setup()
  }

  init(frame: CGRect, text: String) {
    self.text = text
    vibrancyView = UIVisualEffectView(effect: blurEffect)
    super.init(frame: frame)
    setup()
  }

  convenience init(frame: CGRect, text: String, textColor: UIColor) {
    self.init(frame: frame, text: text)
    self.textColor = textColor
  }

  // Make a convenience so frame adjusts to the text width

  required init?(coder aDecoder: NSCoder) {
    text = ""
    vibrancyView = UIVisualEffectView(effect: blurEffect)
    super.init(coder: aDecoder)
    setup()
  }

  override func layoutSubviews() {
    layer.cornerRadius = 8.0
    layer.masksToBounds = true

    activityIndicator.center = CGPoint(x: frame.width / 2,
                                       y: frame.height / 3)

    label.text = text
    label.textAlignment = .center
    label.textColor = textColor
    label.font = UIFont.boldSystemFont(ofSize: 14)

    label.numberOfLines = 1
    label.sizeToFit()
    label.center = CGPoint(x: activityIndicator.center.x,
                           y: frame.height / 1.5)

    vibrancyView.frame = bounds
  }

  func setup() {
    addSubview(vibrancyView)
    addSubview(label)
    addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
}
