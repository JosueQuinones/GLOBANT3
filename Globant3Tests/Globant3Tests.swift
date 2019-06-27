//
//  Globant3Tests.swift
//  Globant3Tests

import XCTest
@testable import Globant3

class Globant3Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    //MARK: - Extra methods
    func createTestData() -> Information {
        return Information(firstName: "Globant", lastName: "3", age: "5", city: "Mexico", photo: "https://www.gqmiddleeast.com/sites/default/files/gqme/styles/766_431_landscape/public/images/2019/04/21/John-Wick-Keanu-Reeves.jpg?itok=tJwVSoRn", skills: [String](), contactInfo: ContactInfo(email: "globant@", cellphone: "55338811", linkedIn: "link"), programming: [[String]](), schoolSummary: SchoolSummary(university: "university", career: "career", generation: "generation"), workExperience: [[String]]())
    }
}
