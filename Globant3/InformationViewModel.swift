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
    var name: Observable<String> = Observable("")
    var lastname: Observable<String> = Observable("")
    var age: Observable<String> = Observable("")
    var city: Observable<String> = Observable("")
    var photo: Observable<UIImage> = Observable(UIImage())
    
    var photoString: Observable<String> = Observable("")
    
    //MARK: - Skills
    var skills: Observable<[String]> = Observable([String]())
    
    //MARK: - Work
    var works: [[Observable<String>]] = [[Observable<String>]]()
    
    //MARK: - Programming
    var languages: [[Observable<String>]] = [[Observable<String>]]()
    
    //MARK: - Education
    var university: Observable<String> = Observable("")
    var career: Observable<String> = Observable("")
    var generation: Observable<String> = Observable("")
    
    //MARK: - Contact
    var email: Observable<String> = Observable("")
    var cellphone: Observable<String> = Observable("")
    var linkedin: Observable<String> = Observable("")
}

extension InformationViewModel {
    func petition() {
        var information: Information? = Information(firstName: "", lastName: "", age: "", city: "", photo: nil, skills: [String](), contactInfo: ContactInfo(email: "", cellphone: "", linkedIn: ""), programming: [[String]](), schoolSummary: SchoolSummary(university: "", career: "", generation: ""), workExperience: [[String]]())
        Networking.shared.getModel(model: information!) { [weak self] model in
            self?.information = model
            DispatchQueue.main.async {
                self?.updateValues()
            }
            self?.requestPhoto(from: self?.information?.photo)
        }
    }
    
    func updateValues() {
        guard let information = information else { return }
        name.value = information.firstName
        lastname.value = information.lastName
        age.value = information.age
        city.value = information.city
        university.value = information.schoolSummary.university
        career.value = information.schoolSummary.career
        generation.value = information.schoolSummary.generation
        email.value = information.contactInfo.email
        cellphone.value = information.contactInfo.cellphone
        linkedin.value = information.contactInfo.linkedIn
        skills.value = information.skills
    }
    
    func requestPhoto(from urlString: String?){
        guard let url = urlString, let urlPhoto = URL(string: url) else { return }
        Networking.shared.getImage(from: urlPhoto) { [weak self] image in
            DispatchQueue.main.async {
                self?.photo.value = image
            }
        }
    }
    
}
