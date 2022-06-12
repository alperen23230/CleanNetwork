//
//  UITableView+Loading.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import UIKit

extension UITableView {
    func startLoading() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
        separatorStyle = .none
    }
    
    func stopLoading() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
