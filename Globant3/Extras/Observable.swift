//
//  Observable.swift
//  Globant3
//
//  Created by Ernesto Daniel Mejia Valdiviezo on 6/27/19.
//  Copyright © 2019 Ernesto Daniel Mejia Valdiviezo. All rights reserved.
//

import UIKit

class Observable<ObservedType> {
    private var _value: ObservedType?
    public var value: ObservedType? {
        get {
            return _value
        }
        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    var valueChanged: ((ObservedType?) -> Void)?
    
    init(_ value: ObservedType) {
        _value = value
    }
}

class BoundLabel: UILabel {
    func bind(to observable: Observable<String>) {
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
    
    func bind(to observableArray: Observable<[String]>) {
        observableArray.valueChanged = { [weak self] newValue in
            self?.text = newValue?.joined(separator: "\n")
        }
    }
    
    func bind(to observableDoubleArray: Observable<[[String]]>) {
        observableDoubleArray.valueChanged = { [weak self] newValue in
            
        }
    }

}

class BoundImageView: UIImageView {
    func bind(to observable: Observable<UIImage>) {
        observable.valueChanged = {[weak self] newValue in
            self?.image = newValue
        }
    }
}
