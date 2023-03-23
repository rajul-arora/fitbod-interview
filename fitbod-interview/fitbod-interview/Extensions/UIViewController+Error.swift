//
//  UIViewController+Error.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-23.
//

import UIKit

extension UIViewController {
    func presentAlert(with error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true)
    }
}
