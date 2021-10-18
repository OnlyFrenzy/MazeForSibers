//
//  UIViewController+Extensions.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 19.10.2021.
//

import UIKit

extension UIViewController {
    func pushAlert(title: String, errorMessage: String, actionTitle: String) {
        let alertVC = UIAlertController(title: title,
                                        message: errorMessage,
                                        preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle,
                                   style: .default,
                                   handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
