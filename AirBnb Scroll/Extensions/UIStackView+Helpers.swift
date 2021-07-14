//
//  UIStackView+Helpers.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 12/07/21.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
