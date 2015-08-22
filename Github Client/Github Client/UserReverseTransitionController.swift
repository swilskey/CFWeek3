//
//  UserReverseTransitionController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/20/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserReverseTransitionController: NSObject {
   
}

extension UserReverseTransitionController: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserSearchViewController,
      fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserViewController {
        
        let container = transitionContext.containerView()
        
        toVC.view.alpha = 0
        container.addSubview(toVC.view)
        
        let snapShot = fromVC.userImageView.snapshotViewAfterScreenUpdates(false)
        let indexPath = fromVC.userCellIndex
        let userCell = toVC.userCollectionView.cellForItemAtIndexPath(indexPath!) as! UserCollectionCell
        snapShot.frame = container.convertRect(fromVC.userImageView.frame, fromCoordinateSpace: fromVC.userImageView.superview!)
        
        container.addSubview(snapShot)
        
        toVC.view.layoutIfNeeded()
        fromVC.userImageView.hidden = true
        
        let destinationFrame = container.convertRect(userCell.userImageView.frame, fromCoordinateSpace: userCell.userImageView.superview!)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
          snapShot.frame = destinationFrame
          toVC.view.alpha = 1
        }, completion: { (finished) -> Void in
          userCell.hidden = false
          snapShot.removeFromSuperview()
          
          if finished {
            transitionContext.completeTransition(finished)
          } else {
            transitionContext.completeTransition(finished)
          }
        })
        
    }
  }
}
