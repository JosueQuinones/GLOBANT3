//
//  String+Localize.swift
//  Globant3
//
//

import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "String not localizable")
    }
}
