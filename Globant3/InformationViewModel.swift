//
//  InformationViewModel.swift
//  Globant3

import UIKit

protocol InformationViewModelProtocol {
    var information: Information? { get set }
}

public class InformationViewModel: InformationViewModelProtocol {
    
    //MARK: - Model instance
    var information: Information?
    
    //MARK: - Class variables
    private var network = Networking()
    
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
    var works: [[String]] = [[String]]()
    var onFinish: (() -> Void)?
    
    //MARK: - Programming
    var languages: [[String]] = [[String]]()
    
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
        network.getModel(model: information!) { [weak self] model in
            self?.information = model
            DispatchQueue.main.async {
                self?.updateValues()
            }
            self?.requestPhoto(from: self?.information?.photo)
        }
    }
    
    func requestPhoto(from urlString: String?){
        guard let url = urlString, let urlPhoto = URL(string: url) else { return }
        network.getImage(from: urlPhoto) { [weak self] image in
            DispatchQueue.main.async {
                self?.photo.value = image
            }
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
        updateStacksValues()
    }
    
    func updateStacksValues(){
        information?.workExperience?.forEach { jobArray in
            works.append(jobArray)
        }
        information?.programming.forEach{ programmingArray in
            languages.append(programmingArray)
        }
        onFinish?()
    }
    
}
