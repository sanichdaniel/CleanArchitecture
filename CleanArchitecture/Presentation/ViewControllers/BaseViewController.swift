//
//  BaseViewController.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {

    let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        self.view.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func showErrorToast(_ content: String) {
        var style = ToastStyle()
        // this is just one of many style options
        style.messageColor = .white
        style.backgroundColor = .red
        let superview = self.navigationController?.view! ?? self.view!
        superview.makeToast(content, duration: 5.0, position: .top, style: style)
    }
}
