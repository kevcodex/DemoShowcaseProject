//
//  DetailsViewController.swift
//  SampleProject
//
//  Created by Kirby on 6/20/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

// shows details of the feed
class DetailsViewController: UIViewController {

  var result: ObjectFeed!

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var navigationBar: UINavigationBar!

  override func viewDidLoad() {
    super.viewDidLoad()

    dateLabel.text = result.readableDate
    titleLabel.text = result.title
    descriptionLabel.text = result.description

    let colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
    let locations: [CGFloat] = [0.0, 1.0]
    let gradientImage = result.image?.createGradient(with: colors, at: locations)

    imageView.image = gradientImage
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    navigationBar.isHidden = false
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    // navigationBar.tintColor = UIColor.white
  }
}

// MARK: - Actions
extension DetailsViewController {
  @IBAction func ShareTapped(_ sender: UIBarButtonItem) {

    if let image = result.image {
      let vc = UIActivityViewController(activityItems: [result.title, image], applicationActivities: [])
      present(vc, animated: true)
    }
  }

  @IBAction func backTapped(_ sender: UIBarButtonItem) {

    dismiss(animated: true, completion: nil)
  }
}
