//
//  Information.swift
//  Globant3

import Foundation

// MARK: - Information
struct Information: Codable {
    let firstName: String
    let lastName: String
    let age: String
    let city: String
    let skills: [String]
    let contactInfo: ContactInfo
    let programming: [[String]]
    let schoolSummary: SchoolSummary
    let workExperience: [[String]]
}

// MARK: - ContactInfo
struct ContactInfo: Codable {
    let email: String
    let cellphone: String
    let linkedIn: String
}

// MARK: - SchoolSummary
struct SchoolSummary: Codable {
    let university: String
    let career: String
    let generation: String
}
