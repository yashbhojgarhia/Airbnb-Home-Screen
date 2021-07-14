//
//  UIImage+Helpers.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 12/07/21.
//

import UIKit

extension UIImage {
    convenience init?(named name: String?) {
        guard let name = name else { return nil }
        self.init(named: name)
    }
}
