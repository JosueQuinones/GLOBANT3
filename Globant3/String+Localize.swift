//
//  String+Localize.swift
//  Globant3
//
//  Created by Josue Emanuel Quinones Rivera on 6/26/19.
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "String not localizable")
    }
}
