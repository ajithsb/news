//
//  NetworkManager.swift
//  News
//
//  Created by Ajith SB 
//

import Foundation
/*
 
class NetworkManager {
    
    // Singleton instance
    static let shared = NetworkManager()
    
    // Private initializer to ensure singleton usage
    private init() {}
    
    // Function to create URLRequest with query parameters
    private func createRequest(url: URL, method: HTTPMethod, queryParams: [String: String] = [:], body: Data? = nil) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = body
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // Function to perform GET request with query parameters and decode JSON response
    func getRequest<T: Codable>(url: URL, queryParams: [String: String] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        let request = createRequest(url: url, method: .get, queryParams: queryParams)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "com.networkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
    
    // Function to perform POST request with query parameters and decode JSON response
    func postRequest<T: Codable>(url: URL, queryParams: [String: String] = [:], body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        let request = createRequest(url: url, method: .post, queryParams: queryParams, body: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "com.networkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
}
 */

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// Protocol for creating URLRequest
protocol RequestCreatable {
    func createRequest(url: URL, method: HTTPMethod, queryParams: [String: String], body: Data?) -> URLRequest
}

// Protocol for handling network responses
protocol NetworkRequestable {
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}


class NetworkManager: RequestCreatable, NetworkRequestable {
    
    // Singleton instance
    static let shared = NetworkManager()
    
    // Private initializer to ensure singleton usage
    private init() {}
    
    // MARK: - RequestCreatable Protocol
    func createRequest(url: URL, method: HTTPMethod, queryParams: [String: String] = [:], body: Data? = nil) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = body
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - NetworkRequestable Protocol
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "com.networkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
}
