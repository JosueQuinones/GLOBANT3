//
//  ViewController.swift
//  Globant3
//
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var skillsLbl: UILabel!
    @IBOutlet weak var universityLbl: UILabel!
    @IBOutlet weak var careerLbl: UILabel!
    @IBOutlet weak var generationLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var cellPhoneLbl: UILabel!
    @IBOutlet weak var linkedInLbl: UILabel!
    @IBOutlet weak var workStackView: UIStackView?
    @IBOutlet weak var programmingStackView: UIStackView!
    
    //MARK: - Titles outletd
    @IBOutlet weak var skillsTitleLbl: UILabel!
    @IBOutlet weak var workTitleLbl: UILabel!
    @IBOutlet weak var programmingTitleLbl: UILabel!
    @IBOutlet weak var educationTitleLbl: UILabel!
    @IBOutlet weak var contactTitleLbl: UILabel!
    
    
    
    //MARK: - class variables
    var infoViewModel = InformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "main_title".localize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        petition()
//        configure()
    }
    
    func petition() {
        var information: Information? = Information(firstName: "", lastName: "", age: "", city: "", photo: nil, skills: [String](), contactInfo: ContactInfo(email: "", cellphone: "", linkedIn: ""), programming: [[String]](), schoolSummary: SchoolSummary(university: "", career: "", generation: ""), workExperience: [[String]]())
        Networking.shared.getModel(model: information!) { [weak self] model in
            self?.infoViewModel.information = model
            DispatchQueue.main.async {
                self?.configure()
            }
            self?.requestPhoto(from: model?.photo)
        }
    }
    
    func requestPhoto(from urlString: String?){
        guard let url = urlString, let urlPhoto = URL(string: url) else { return }
        Networking.shared.getImage(from: urlPhoto) { [weak self] image in
            DispatchQueue.main.async {
                self?.userImageView.image = image
            }
        }
    }

    func configure() {
        configureMainView()
        configureSkillsView()
        configureWorkView()
        configureProgrammingView()
        configureEducationView()
        configureContactView()
    }

    func configureMainView() {
        firstNameLbl.text = infoViewModel.name
        lastNameLbl.text = infoViewModel.lastname
        ageLbl.text = infoViewModel.age
        cityLbl.text = infoViewModel.city
    }
    
    func configureSkillsView() {
        skillsTitleLbl.text = "skills_title".localize()
        skillsLbl.text = infoViewModel.skills
    }
    
    func configureWorkView() {
        workTitleLbl.text = "work_experience_title".localize()
        guard let workStackView = workStackView else { return }
        workStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titles = [UILabel]()
        
        infoViewModel.works?.forEach { workExperience in
            let nameJobTitle = UILabel()
            nameJobTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            nameJobTitle.text = "Name: "
            titles.append(nameJobTitle)
            nameJobTitle.numberOfLines = 0
            
            let nameJob = UILabel()
            nameJob.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            nameJob.text = workExperience[0]
            nameJobTitle.numberOfLines = 0
            
            let dateTitle = UILabel()
            dateTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            dateTitle.text = "Start date: "
            titles.append(dateTitle)
            dateTitle.numberOfLines = 0
            
            let date = UILabel()
            date.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            date.text = workExperience[1]
            date.numberOfLines = 0
            
            let descriptionTitle = UILabel()
            descriptionTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            descriptionTitle.text = "Description: "
            descriptionTitle.numberOfLines = 0
            titles.append(descriptionTitle)
            
            let description = UILabel()
            description.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            description.numberOfLines = 0
            description.text = workExperience[2]
            description.lineBreakMode = .byWordWrapping
            
            let nameStack = UIStackView()
            nameStack.addArrangedSubview(nameJobTitle)
            nameStack.addArrangedSubview(nameJob)
            nameStack.spacing = 30
            
            let dateStack = UIStackView()
            dateStack.addArrangedSubview(dateTitle)
            dateStack.addArrangedSubview(date)
            dateStack.spacing = 30
            
            let descriptionStack = UIStackView()
            descriptionStack.addArrangedSubview(descriptionTitle)
            descriptionStack.addArrangedSubview(description)
            descriptionStack.spacing = 30
            
            workStackView.addArrangedSubview(nameStack)
            workStackView.addArrangedSubview(dateStack)
            workStackView.addArrangedSubview(descriptionStack)
        }
        guard titles.count >= 2, let firstLabel = titles.first else { return }
        for i in 1 ..< titles.count {
            titles[i].widthAnchor.constraint(equalTo: firstLabel.widthAnchor, multiplier: 1).isActive = true
        }
    }
    
    
    func configureProgrammingView() {
        programmingTitleLbl.text = "programming_languages_title".localize()
        guard let programmingStackView = programmingStackView else { return }
        programmingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        infoViewModel.languages?.forEach { language in
            let languageLabel = UILabel()
            languageLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            languageLabel.text = language[0]
            languageLabel.numberOfLines = 0
            languageLabel.textAlignment = .left
            
            let timeLabel = UILabel()
            timeLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            timeLabel.text = language[1]
            timeLabel.numberOfLines = 0
            timeLabel.textAlignment = .left
            
            let languageStackView = UIStackView()
            languageStackView.addArrangedSubview(languageLabel)
            languageStackView.addArrangedSubview(timeLabel)
            languageStackView.spacing = 30
            
            programmingStackView.addArrangedSubview(languageStackView)
        }
    }
    
    func configureEducationView () {
        educationTitleLbl.text = "school_summary_title".localize()
        universityLbl.text = infoViewModel.university
        careerLbl.text = infoViewModel.career
        generationLbl.text = infoViewModel.generation
    }
    
    func configureContactView(){
        contactTitleLbl.text = "contact_info_title".localize()
        emailLbl.text = infoViewModel.email
        cellPhoneLbl.text = infoViewModel.cellphone
        linkedInLbl.text = infoViewModel.linkedin
    }
}

