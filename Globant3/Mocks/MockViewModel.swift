//
//  MockViewModel.swift
//  Globant3

import Foundation

class MockViewModel: InformationViewModelProtocol {
    var information: Information?
    
    init(information: Information) {
        self.information = information
    }
    
    func updateValues() {
        
    }
}
