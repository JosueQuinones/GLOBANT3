//
//  InformationViewModel.swift
//  Globant3
//
//  Created by Josue Emanuel Quinones Rivera on 6/26/19.
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import UIKit

public class InformationViewModel {
    
    //MARK: - Model instance
    var information: Information?
    
    //MARK: - Main info
    var name: String? {
        return information?.firstName
    }
    var lastname: String? {
        return information?.lastName
    }
    var age: String? {
        return information?.age
    }
    var city: String? {
        return information?.city
    }
    
    //MARK: - Skills
    var skills: String? {
        return information?.skills.joined(separator: "\n")
    }
    
    //MARK: - Work
    var works: [[String]]? {
        return information?.workExperience
    }
    
    //MARK: - Programming
    var languages: [[String]]? {
        return information?.programming
    }
    
    //MARK: - Education
    var university: String? {
        return information?.schoolSummary.university
    }
    var career: String? {
        return information?.schoolSummary.career
    }
    var generation: String? {
        return information?.schoolSummary.generation
    }
    
    //MARK: - Contact
    var email: String? {
        return information?.contactInfo.email
    }
    var cellphone: String? {
        return information?.contactInfo.cellphone
    }
    var linkedin: String? {
        return information?.contactInfo.linkedIn
    }
}
