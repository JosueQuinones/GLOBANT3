//
//  Result.swift
//  Globant3
//
//  Created by Josue Emanuel Quinones Rivera on 6/26/19.
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import Foundation

public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}
