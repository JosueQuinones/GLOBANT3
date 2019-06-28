//
//  Globant3Tests.swift
//  Globant3Tests

import XCTest
@testable import Globant3

class Globant3Tests: XCTestCase {

    func testNetworkingGetDataNotNil() {
        //given
        let mock = MockNetworking()
        let expectation = XCTestExpectation(description: "Data not nil")
        mock.data = getDataInfo(from: "Info")
        
        //when
        mock.getData { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        //then
        wait(for: [expectation], timeout: 5)
    }

    func testParseToModel() {
        //given
        let mock = MockNetworking()
        let expectation = XCTestExpectation(description: "Data parsed")
        mock.data = getDataInfo(from: "Info")
        var information = Information(firstName: "", lastName: "", age: "", city: "", photo: nil, skills: [String](), contactInfo: ContactInfo(email: "", cellphone: "", linkedIn: ""), programming: [[String]](), schoolSummary: SchoolSummary(university: "", career: "", generation: ""), workExperience: [[String]]())
        //when
        mock.getModel(model: information) { model in
            if let model = model {
                XCTAssertNotNil(model)
            }
            expectation.fulfill()
        }
        //then
        wait(for: [expectation], timeout: 5)
    }
    
    func testParseToModelNilWithIncorrectData() {
        //given
        let mock = MockNetworking()
        let expectation = XCTestExpectation(description: "Data parsed")
        mock.data = getDataInfo(from: "badInfo")
        var information = Information(firstName: "", lastName: "", age: "", city: "", photo: nil, skills: [String](), contactInfo: ContactInfo(email: "", cellphone: "", linkedIn: ""), programming: [[String]](), schoolSummary: SchoolSummary(university: "", career: "", generation: ""), workExperience: [[String]]())
        //when
        mock.getModel(model: information) { model in
            if let _ = model {
                XCTFail()
            } else {
                XCTAssertNil(model)
            }
            expectation.fulfill()
        }
        //then
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadImage() {
        //given
        let mock = MockNetworking()
        let expectation = XCTestExpectation(description: "Image load")
        guard let url = Bundle.main.url(forResource: "JW", withExtension: "jpg") else  {
            XCTFail()
            return
        }
        //when
        mock.getImage(from: url) { image in
            if let image = image {
                XCTAssertNotNil(image)
            }
            expectation.fulfill()
        }
        //then
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadNilWithIncorrectImage() {
        //given
        let url = Bundle.main.url(forResource: "fake", withExtension: "jpg")
         if let _ = url {
            XCTFail()
        }else {
            XCTAssertNil(url)
            return
        }
    }
    
    
    func testMainViewInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        //when
        XCTAssertEqual(mock.information?.firstName, "Globant")
        XCTAssertEqual(mock.information?.lastName, "3")
        XCTAssertEqual(mock.information?.age, "5")
        XCTAssertEqual(mock.information?.city, "Mexico")
        XCTAssertEqual(mock.information?.photo, "https://www.gqmiddleeast.com/sites/default/files/gqme/styles/766_431_landscape/public/images/2019/04/21/John-Wick-Keanu-Reeves.jpg?itok=tJwVSoRn")
    }
    
    func testSkillsViewInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        let skills = mock.information?.skills.joined(separator: "\n")
        //when
        XCTAssertEqual(skills, "reflexe\ndriver")
    }
    
    func testWorkExperienceInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        let works = [["Tarasov Industries", "August 2012", "I was a legendary hitman who worked for the Tarasov Mob until my retirement."],
        ["Army", "May 2009", "I served in the United States Marine Corps for three years doing different missions successfully and too many kills."],
        ["Cisco", "June 2006", "I was required to prepare and examine financial records. I made sure that records are accurate and that taxes were paid properly and on time."]]
        //when
        XCTAssertEqual(mock.information?.workExperience, works)
    }
    
    func testProgrammingInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        let programming = [["swift", "10 months"],
                           ["sql", "6 months"],
                           ["javascript", "6 months"],
                           ["php", "6 months"],
                           ["python", "2 months"]]
        //when
        XCTAssertEqual(mock.information?.programming, programming)
    }
    
    func testEducationInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        //when
        XCTAssertEqual(mock.information?.schoolSummary.university, "university")
        XCTAssertEqual(mock.information?.schoolSummary.career, "career")
        XCTAssertEqual(mock.information?.schoolSummary.generation, "generation")
    }
    
    func testContactInformationOk() {
        //given
        let information = createTestData()
        let mock = MockViewModel(information: information)
        //when
        XCTAssertEqual(mock.information?.contactInfo.email, "globant@")
        XCTAssertEqual(mock.information?.contactInfo.cellphone, "55338811")
        XCTAssertEqual(mock.information?.contactInfo.linkedIn, "link")
    }
}

extension Globant3Tests {
    func getDataInfo(from resource: String) -> Data {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else { fatalError() }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return data
    }
    
    
    //MARK: - Extra methods
    func createTestData() -> Information {
        return Information(firstName: "Globant", lastName: "3", age: "5", city: "Mexico", photo: "https://www.gqmiddleeast.com/sites/default/files/gqme/styles/766_431_landscape/public/images/2019/04/21/John-Wick-Keanu-Reeves.jpg?itok=tJwVSoRn", skills: ["reflexe", "driver"], contactInfo: ContactInfo(email: "globant@", cellphone: "55338811", linkedIn: "link"), programming: [["swift", "10 months"],
                           ["sql", "6 months"],
                           ["javascript", "6 months"],
                           ["php", "6 months"],
                           ["python", "2 months"]], schoolSummary: SchoolSummary(university: "university", career: "career", generation: "generation"), workExperience: [["Tarasov Industries", "August 2012", "I was a legendary hitman who worked for the Tarasov Mob until my retirement."],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ["Army", "May 2009", "I served in the United States Marine Corps for three years doing different missions successfully and too many kills."],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ["Cisco", "June 2006", "I was required to prepare and examine financial records. I made sure that records are accurate and that taxes were paid properly and on time."]])
    }
}
