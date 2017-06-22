//
//  CustomDissmissController.swift
//  SampleProject
//
//  Created by Kirby on 6/20/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

// animated a faed effec
class CustomDismissController: NSObject, UIViewControllerAnimatedTransitioning {

  var originFrame = CGRect.zero

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
      let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
      return
    }

    let containerView = transitionContext.containerView

    let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)

    snapshot?.layer.masksToBounds = true

    containerView.addSubview(toVC.view)
    containerView.addSubview(snapshot!)
    toVC.view.alpha = 0.0

    // fixes if user orientents listview did not re-orientate
    toVC.view.frame = originFrame

    let duration = transitionDuration(using: transitionContext)

    UIView.animate(withDuration: duration, animations: { () -> Void in

      fromVC.view.alpha = 0.0
      toVC.view.alpha = 1.0

    }, completion: { _ in

      snapshot?.removeFromSuperview()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

    })
  }
}
