//
//  Globant3UITests.swift
//  Globant3UITests

import XCTest

class Globant3UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testProfileImageViewExists() {
        XCTAssertTrue(app.images["profileImageView"].exists)
    }
    
    func testNameLabelExists() {
        XCTAssertTrue(app.staticTexts["nameLabel"].exists)
    }
    
    func testLastnameLabelExists() {
        XCTAssertTrue(app.staticTexts["lastnameLabel"].exists)
    }
    
    func testAgeLabelExists() {
        XCTAssertTrue(app.staticTexts["ageLabel"].exists)
    }
    
    func testCityLabelExists() {
        XCTAssertTrue(app.staticTexts["cityLabel"].exists)
    }
    
    func testSkillsTitleExists() {
        XCTAssertTrue(app.otherElements["Skills"].exists)
    }
    
    func testWorkTitleExists() {
        XCTAssertTrue(app.staticTexts["workTitle"].exists)
    }
    
    func testProgrammingTitleExists() {
        XCTAssertTrue(app.staticTexts["programmingTitle"].exists)
    }
    
    func testEducationTitleExists() {
        XCTAssertTrue(app.staticTexts["educationTitle"].exists)
    }
    
    func testUniversityLabelExists() {
        XCTAssertTrue(app.staticTexts["universityLabel"].exists)
    }
    
    func testCareerLabelExists() {
        XCTAssertTrue(app.staticTexts["careerLabel"].exists)
    }
    
    func testGenerationLabelExists() {
        XCTAssertTrue(app.staticTexts["generationLabel"].exists)
    }
    
    func testContactTitleExists() {
        XCTAssertTrue(app.staticTexts["contactTitle"].exists)
    }
    
    func testEmailLabelExists() {
        XCTAssertTrue(app.staticTexts["emailLabel"].exists)
    }
    
    func testCellLabelExists() {
        XCTAssertTrue(app.staticTexts["cellLabel"].exists)
    }
    
    func testLinkLabelExists() {
        XCTAssertTrue(app.staticTexts["linkLabel"].exists)
    }

}
