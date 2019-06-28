//
//  MockViewModel.swift
//  Globant3
//
//  Created by Josue Emanuel Quinones Rivera on 6/27/19.
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import Foundation

class MockViewModel: InformationViewModelProtocol {
    var information: Information?
    
    init(information: Information) {
        self.information = information
    }
    
    func updateValues() {
        
    }
}
