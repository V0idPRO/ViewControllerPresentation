//
//  ViewController.swift
//  ViewControllerPresentation
//
//  Created by V0id on 03/12/2017.
//  Copyright © 2017 V0id. All rights reserved.
//

import UIKit

class CustomUIPresentationController: UIPresentationController {
    public var customContainer: UIView!
    public override var frameOfPresentedViewInContainerView: CGRect {
        return self.customContainer.bounds
    }

    public override func presentationTransitionWillBegin() {
        self.customContainer.addSubview(self.containerView!)
        self.containerView?.frame = self.customContainer.bounds
        self.presentedView?.layer.cornerRadius = 20
        self.presentedView?.clipsToBounds = true
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    private var presentInView: Bool = false
    private var showModalViewController: ShowModalViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.layer.cornerRadius = 20
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func presentModallyAction(_ sender: Any) {
        self.presentInView = false
        self.showModalViewController?.dismiss()

        self.showModalViewController = ShowModalViewController()
        self.showModalViewController?.present(from: self)
    }

    @IBAction func presentInViewAction(_ sender: Any) {
        self.presentInView = true
        self.showModalViewController?.dismiss()

        self.showModalViewController = ShowModalViewController()
        self.showModalViewController?.present(from: self)
    }

    //MARK: - Presentation Magic
    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        if self.presentInView {
            viewControllerToPresent.modalPresentationStyle = .custom
            viewControllerToPresent.modalTransitionStyle = .crossDissolve
            viewControllerToPresent.transitioningDelegate = self
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomUIPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.customContainer = self.containerView
        return presentationController
    }
}
