//
//  APIClient.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

protocol APIClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, APIError>
}

extension APIClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, APIError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        if let queryParameters = endpoint.queryParameters {
            urlComponents.queryItems = queryParameters.compactMap { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        }
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decodeError)
                }
                return .success(decodedResponse)
            default:
                return .failure(.invalidStatusCode(response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

