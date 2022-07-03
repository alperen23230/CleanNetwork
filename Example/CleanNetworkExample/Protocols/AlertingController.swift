//
//  AlertingController.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import Foundation
import UIKit

protocol AlertingController {
    func showSimpleAlert(title: String?, message: String?, actionTitle: String?, actionHandler: VoidClosure?)
}

extension AlertingController where Self: UIViewController {
    func showSimpleAlert(title: String?, message: String?, actionTitle: String? = "OK", actionHandler: VoidClosure? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
