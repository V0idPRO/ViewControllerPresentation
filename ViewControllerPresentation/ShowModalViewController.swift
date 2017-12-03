//
//  ShowModalViewController.swift
//  ViewControllerPresentation
//
//  Created by V0id on 03/12/2017.
//  Copyright © 2017 V0id. All rights reserved.
//

import UIKit

public class ShowModalViewController {
    private var viewController: UIViewController

    public init() {
        self.viewController = UIViewController()
        self.prepareViewController(self.viewController)
    }

    private func prepareViewController(_ viewController: UIViewController) {
        let label = UILabel()
        label.text = "I'm label"
        label.textColor = UIColor.white
        self.viewController.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: label.superview!.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: label.superview!.centerYAnchor).isActive = true

        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.viewController.view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 100).isActive = true

        self.viewController.view.backgroundColor = UIColor.purple
    }

    @objc
    private func closeAction() {
        self.dismiss()
    }

    public func present(from presentationViewController: UIViewController) {
        presentationViewController.present(self.viewController, animated: true, completion: nil)
    }

    public func dismiss() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
