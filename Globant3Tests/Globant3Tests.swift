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
        return Information(firstName: "Globant", lastName: "3", age: "5", city: "Mexico", photo: "https://www.gqmiddleeast.com/sites/default/files/gqme/styles/766_431_landscape/public/images/2019/04/21/John-Wick-Keanu-Reeves.jpg?itok=tJwVSoRn", skills: [String](), contactInfo: ContactInfo(email: "globant@", cellphone: "55338811", linkedIn: "link"), programming: [[String]](), schoolSummary: SchoolSummary(university: "university", career: "career", generation: "generation"), workExperience: [[String]]())
    }
}
