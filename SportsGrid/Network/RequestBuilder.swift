//
//  RequestBuilder.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Foundation

final class RequestBuilder {
    
    private var request: URLRequest?
    
    func addUrlComponents(from route: RouteProvider) throws -> Self {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.basePath + route.path
        
        if case .get(let params) = route.method, !params.isEmpty {
            components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        guard let url = components.url else { throw NetworkError.invalidURL }
        self.request = URLRequest(url: url)
        return self
    }
    
    func build(from route: RouteProvider) throws -> URLRequest {
        guard var newRequest = self.request else { throw NetworkError.invalidURL }
        newRequest.httpMethod = route.method.rawValue
        if !route.headers.isEmpty {
            newRequest.allHTTPHeaderFields = route.headers
        }
        newRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return newRequest
    }
    
}
