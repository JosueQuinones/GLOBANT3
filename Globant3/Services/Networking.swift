//
//  Networking.swift
//  Globant3

import UIKit

public class Networking {
    
    //MARK: - Singletone
    public static var shared = Networking()
    
    //MARK: - Information required for API
    private var baseURLString: String?
    private var endpoint: String?
    
    //MARK: - URLSession
    private var defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    private init() {
        baseURLString = getServerURL(from: "ServerURL")
    }
    
    //MARK: - Auxiliar function for read serverURL
    private func getServerURL(from key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
    
    //MARK: - Get Image from url
    public func getImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
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
    private func getData(completion: @escaping (Result<Data, NetworkError>) -> Void) {
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
