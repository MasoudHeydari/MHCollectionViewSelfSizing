//
// Created by Masoud Heydari on 2019-07-23.
// Copyright (c) 2019 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIView {

    public func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    public func removeAllSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
