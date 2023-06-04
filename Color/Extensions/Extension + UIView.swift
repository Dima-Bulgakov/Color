//
//  Extension + UIView.swift
//  Color
//
//  Created by Dima on 01.06.2023.
//

import UIKit

// Custom addSubview with translatesAutoresizingMaskIntoConstraints
extension UIView {
    func addMySubview(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

