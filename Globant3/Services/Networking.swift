//
//  Networking.swift
//  Globant3

import UIKit

protocol NetworkingProtocol {
    var dataTask: URLSessionDataTask? { get set }
    func getModel<Model: Codable>(model: Model, completion: @escaping (Model?) -> Void)
    func getData(completion: @escaping (Result<Data, NetworkError>) -> Void)
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

public class Networking: NetworkingProtocol {
    
    //MARK: - Information required for API
    private var baseURLString: String?
    private var endpoint: String?
    
    //MARK: - URLSession
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    init() {
        baseURLString = getServerURL(from: "SERVER_URL")
    }
    
    //MARK: - Auxiliar function for read serverURL
    private func getServerURL(from key: String) -> String? {
        return Configuration.value(for: key)
    }
    
    //MARK: - Get Image from url
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    //MARK: - Parsing data to model
    public func getModel<Model: Codable>(model: Model, completion: @escaping (Model?) -> Void) {
        let jsonDecoder = JSONDecoder()
        
        getData { result in
            switch result {
            case .success(let data):
                if let json = try? jsonDecoder.decode(Model.self, from: data) {
                    completion(json)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    //MARK: - Fetching data from service
    func getData(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let url = urlAssemble(endpoint: endpoint) {
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let data = data, let _ = response as? HTTPURLResponse {
                    completion(.success(data))
                } else if let _ = error {
                    completion(.failure(.fetchError))
                }
            }
            dataTask?.resume()
        }
    }
    
    //MARK: - URL Assembler
    private func urlAssemble(endpoint: String?) -> URL? {
        guard let baseURLString = baseURLString else { return nil }
        guard var baseURL = URL(string: baseURLString) else { return nil }
        
        if let endpoint = endpoint {
            baseURL.appendPathComponent(endpoint)
        }
        
        return baseURL
    }
}
