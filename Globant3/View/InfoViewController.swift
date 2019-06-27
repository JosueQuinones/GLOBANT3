//
//  ViewController.swift
//  Globant3
//
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userImageView: BoundImageView!
    @IBOutlet weak var firstNameLbl: BoundLabel!
    @IBOutlet weak var lastNameLbl: BoundLabel!
    @IBOutlet weak var ageLbl: BoundLabel!
    @IBOutlet weak var cityLbl: BoundLabel!
    @IBOutlet weak var skillsLbl: BoundLabel!
    @IBOutlet weak var universityLbl: BoundLabel!
    @IBOutlet weak var careerLbl: BoundLabel!
    @IBOutlet weak var generationLbl: BoundLabel!
    @IBOutlet weak var emailLbl: BoundLabel!
    @IBOutlet weak var cellPhoneLbl: BoundLabel!
    @IBOutlet weak var linkedInLbl: BoundLabel!
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
        infoViewModel.onFinish = { [weak self] in
            self?.configureWorkView()
            self?.configureProgrammingView()
        }
        configure()
        infoViewModel.petition()
    }

    func configure() {
        configureMainView()
        configureSkillsView()
        configureEducationView()
        configureContactView()
        configureImageView()
    }
    
    func configureImageView() {
        userImageView.bind(to: infoViewModel.photo)
    }

    func configureMainView() {
        firstNameLbl.bind(to: infoViewModel.name)
        lastNameLbl.bind(to: infoViewModel.lastname)
        ageLbl.bind(to: infoViewModel.age)
        cityLbl.bind(to: infoViewModel.city)
    }
    
    func configureSkillsView() {
        skillsTitleLbl.text = "skills_title".localize()
        skillsLbl.bind(to: infoViewModel.skills)
    }
    
    func configureWorkView() {
        workTitleLbl.text = "work_experience_title".localize()
        guard let workStackView = workStackView else { return }
        workStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titles = [UILabel]()
        
        infoViewModel.works.forEach { workExperience in
            let nameJobTitle = UILabel()
            nameJobTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            nameJobTitle.text = "Name: "
            titles.append(nameJobTitle)
            nameJobTitle.numberOfLines = 0
            
            let nameJob = BoundLabel()
            nameJob.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            nameJob.text = workExperience[0]
            nameJobTitle.numberOfLines = 0
            
            let dateTitle = UILabel()
            dateTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            dateTitle.text = "Start date: "
            titles.append(dateTitle)
            dateTitle.numberOfLines = 0
            
            let date = BoundLabel()
            date.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            date.text = workExperience[1]
            date.numberOfLines = 0
            
            let descriptionTitle = UILabel()
            descriptionTitle.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            descriptionTitle.text = "Description: "
            descriptionTitle.numberOfLines = 0
            titles.append(descriptionTitle)
            
            let description = BoundLabel()
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
        
        infoViewModel.languages.forEach { language in
            let languageLabel = BoundLabel()
            languageLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
            languageLabel.text = language[0]
            languageLabel.numberOfLines = 0
            languageLabel.textAlignment = .left
            
            let timeLabel = BoundLabel()
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
        universityLbl.bind(to: infoViewModel.university)
        careerLbl.bind(to: infoViewModel.career)
        generationLbl.bind(to: infoViewModel.generation)
    }
    
    func configureContactView(){
        contactTitleLbl.text = "contact_info_title".localize()
        emailLbl.bind(to: infoViewModel.email)
        cellPhoneLbl.bind(to: infoViewModel.cellphone)
        linkedInLbl.bind(to: infoViewModel.linkedin)
    }
}

