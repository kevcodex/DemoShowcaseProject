//
//  ListViewController.swift
//  SampleProject
//
//  Created by Kirby on 6/19/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

// Shows a collection view of the objects recieved
class ListViewController: UIViewController {

  let client = NetworkClient()

  var results: [ObjectFeed] = []

  var activityIndicator = ActivityProgressHud()

  fileprivate var cellFrame: CGRect!

  fileprivate let customTransition = CustomTransitionController()
  fileprivate let customDismissTransition = CustomDismissController()

  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

    showActivityIndicator(title: "Loading")

    collectionView.dataSource = self
    collectionView.delegate = self

    let request = NetworkAPI.Feed()
    client.send(request: request) { [weak self] result in

      guard let strongSelf = self else {
        return
      }

      switch result {
      case let .success(response):

        strongSelf.results = response.items

        DispatchQueue.main.async {
          strongSelf.collectionView.reloadData()
          strongSelf.hideActivityIndicator()
        }

      case let .failure(error):
        print(error)
        DispatchQueue.main.async {
          strongSelf.collectionView.reloadData()
          strongSelf.hideActivityIndicator()
        }
      }
    }
  }
}

// MARK: - Collection View datasource
extension ListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell

    let result = results[indexPath.row]

    cell.result = result
    cell.layer.shouldRasterize = true
    cell.layer.rasterizationScale = UIScreen.main.scale

    return cell
  }

  func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let sender = collectionView.cellForItem(at: indexPath)

    performSegue(withIdentifier: "ShowDetails", sender: sender)
  }
}

// MARK: - Collection View Delegate

extension ListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width

    var baseCellWidth: CGFloat = 375.0

    // for screens twice as large than the intrinsic base cell, have two cells per row
    // otherwise stretch to width of screensize
    if screenWidth > baseCellWidth * 2 {
      baseCellWidth = screenWidth / 2
    } else {
      baseCellWidth = screenWidth
    }

    return CGSize(width: baseCellWidth, height: 200)
  }
}

// MARK: - Segue

extension ListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cell = sender as? FeedCell,
      let indexPath = collectionView.indexPath(for: cell),
      let detailsViewController = segue.destination as? DetailsViewController

    else {
      return
    }

    let theAttributes: UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
    cellFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)

    detailsViewController.transitioningDelegate = self
    detailsViewController.result = cell.result
  }
}

// MARK: - Transition View
extension ListViewController {
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    collectionView.collectionViewLayout.invalidateLayout()
  }
}

// MARK: - Transition Delegate
extension ListViewController: UIViewControllerTransitioningDelegate {

  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    customTransition.originFrame = cellFrame
    return customTransition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    customDismissTransition.originFrame = dismissed.view.frame
    return customDismissTransition
  }
}

// MARK: - Activity Presentor Protocol
extension ListViewController: ActivityIndicatorPresentor {
}
