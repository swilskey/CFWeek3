//
//  UserTransitionController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/20/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserTransitionController : NSObject {
  
}

extension UserTransitionController: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    
    return 0.4
  }
  
  //this is the animation
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController,
      toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserViewController {
        
        let container = transitionContext.containerView()
        toVC.view.alpha = 0
        
        //added new vc to container
        container.addSubview(toVC.view)
        
        //Get clicked cell
        let indexPath = fromVC.userCollectionView.indexPathsForSelectedItems().first as! NSIndexPath
        let userCell = fromVC.userCollectionView.cellForItemAtIndexPath(indexPath) as! UserCollectionCell
        
        // Create snapshot of cell
        let snapShot = userCell.userImageView.snapshotViewAfterScreenUpdates(false)

        //Switches frame from cell to container
        snapShot.frame = container.convertRect(userCell.userImageView.frame, fromCoordinateSpace: userCell.userImageView.superview!)
        
        container.addSubview(snapShot)
        
        //Ensure that destination image view is in place
        toVC.view.layoutIfNeeded()
        userCell.hidden = true
        
        let destinationFrame = toVC.userImageView.frame
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
          snapShot.frame = destinationFrame
          toVC.view.alpha = 1
        }, completion: { (finished) -> Void in
          toVC.userImageView.hidden = false
          toVC.userImageView.image = userCell.userImageView.image
          snapShot.removeFromSuperview()
          if finished {
            userCell.hidden = false
            transitionContext.completeTransition(finished)
          } else {
            transitionContext.completeTransition(finished)
          }
        })
    }
  }
}