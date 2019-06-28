//
//  MockNetworking.swift
//  Globant3

import UIKit

class MockNetworking: NetworkingProtocol {
    
    var data: Data?
    var dataTask: URLSessionDataTask?
    
    func getModel<Model>(model: Model, completion: @escaping (Model?) -> Void) where Model : Decodable, Model : Encodable {
        let jsonDecoder = JSONDecoder()
        guard let data = data else { return }
        guard let json = try? jsonDecoder.decode(Model.self, from: data) else {
            completion(nil)
            return
        }
        completion(json)
    }
    
    func getData(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(.fetchError))
        }
        
    }
    
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
}
