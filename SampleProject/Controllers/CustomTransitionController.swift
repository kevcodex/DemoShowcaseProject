//
//  CustomTransitionController.swift
//  SampleProject
//
//  Created by Kirby on 6/20/17.
//  Copyright © 2017 Kirby. All rights reserved.
//

import UIKit

// for animating the "slide" effect
class CustomTransitionController: NSObject, UIViewControllerAnimatedTransitioning {

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

    snapshot?.frame.origin = originFrame.origin
    snapshot?.layer.masksToBounds = true

    containerView.addSubview(toVC.view)
    containerView.addSubview(snapshot!)
    toVC.view.isHidden = true

    let duration = transitionDuration(using: transitionContext)

    UIView.animate(withDuration: duration, animations: { _ in

      fromVC.view.alpha = 0.0

    },
    completion: { _ in

      UIView.animate(withDuration: duration, animations: { _ in

        snapshot?.frame = toVC.view.frame

      }, completion: { _ in

        toVC.view.isHidden = false
        toVC.view.alpha = 1.0
        snapshot?.removeFromSuperview()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

      })

    })
  }
}
