//
//  Information.swift
//  Globant3

import Foundation

// MARK: - Information
struct Information: Codable {
    let firstName, lastName, age, city: String
    let skills: [String]
    let contactInfo: ContactInfo
    let programming: Programming
    let schoolSummary: SchoolSummary
    let workExperience: WorkExperience
}

// MARK: - ContactInfo
struct ContactInfo: Codable {
    let email, cellphone: String
    let linkedIn: String
}

// MARK: - Programming
struct Programming: Codable {
    let languages: [[String]]
}

// MARK: - SchoolSummary
struct SchoolSummary: Codable {
    let university, carreer, generation: String
}

// MARK: - WorkExperience
struct WorkExperience: Codable {
    let jobs: [Job]?
}

struct Job: Codable {
    let job: [String]
}
