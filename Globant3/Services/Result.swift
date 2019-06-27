//
//  Result.swift
//  Globant3

import Foundation

public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}
