//
//  UIViewController+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 27/05/2022.
//

import UIKit

private var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: view.bounds)
        guard let aView = aView else { return }
        aView.backgroundColor = .gray

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView.center
        activityIndicator.startAnimating()
        aView.addSubview(activityIndicator)
        view.addSubview(aView)
    }

    func hideSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }

    func showAlert(title: String = "", message: String = "", actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }

        if presentedViewController as? UIAlertController != nil {
            dismiss(animated: true, completion: nil)
        }

        present(alert, animated: true, completion: nil)
    }
}
