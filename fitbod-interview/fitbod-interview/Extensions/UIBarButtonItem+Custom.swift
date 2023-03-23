//
//  UIBarButtonItem+Custom.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-23.
//

import UIKit

extension UIBarButtonItem {
    static func back(_ action: @escaping () -> Void) -> UIBarButtonItem {
        let uiAction = UIAction { _ in
            action()
        }

        let item = UIBarButtonItem(
            image: .chevronLeft,
            primaryAction: uiAction
        )

        item.tintColor = .label

        return item
    }
}
