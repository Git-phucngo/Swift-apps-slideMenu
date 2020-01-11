//
//  SlideIntTransition.swift
//  Swift-apps-slideMenu
//
//  Created by Sero on 1/10/20.
//  Copyright © 2020 oresnet. All rights reserved.
//

import UIKit

class SlideIntTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
        let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
    
        if isPresenting{
            // Add dimming view
            dimingView.backgroundColor = .black
            dimingView.alpha = 0.0
            containerView.addSubview(dimingView)
            dimingView.frame = containerView.bounds
            // Add menu view controller to container
            containerView.addSubview(toViewController.view)
            
            //Init frame off screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
    
        // Animate onto screen slide in
        let transform = {
            self.dimingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform (translationX: finalWidth, y: 0)
            
        }
        
        // Animate back off screen
        
        let identity = {
            self.dimingView.alpha = 0.0
            fromViewController.view.transform = . identity
            
        }
        
        
        // Animation of transtion
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform(): identity()
        }) {(_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }

}
