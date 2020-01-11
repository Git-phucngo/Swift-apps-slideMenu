//
//  ViewController.swift
//  Swift-apps-slideMenu
//
//  Created by Sero on 1/10/20.
//  Copyright © 2020 oresnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transtion = SlideIntTransition()
    var topView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else{ return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType){
        let title = String( describing: menuType).capitalized
        self.title = title
    
        /* Set New Page*/
        topView?.removeFromSuperview()
        switch menuType {
        case .setting:
                let view = UIView()
                view.backgroundColor = .yellow
                view.frame = self.view.bounds
                self.view.addSubview(view)
                self.topView = view
        case .about:
                let view = UIView()
                view.backgroundColor = .blue
                view.frame = self.view.bounds
                self.view.addSubview(view)
                self.topView = view
        default:
            break
        }
    }
    
}


extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transtion.isPresenting = true
        return transtion
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transtion.isPresenting = false
        return transtion
    }
}

