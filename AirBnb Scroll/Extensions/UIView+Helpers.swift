//
//  UIView+Helpers.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 12/07/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func setBackgroundAlpha(_ alpha: CGFloat) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha)
    }
}
