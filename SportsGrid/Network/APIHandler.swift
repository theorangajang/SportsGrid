//
//  APIProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

protocol APIHandler {
    
    func perform<T: Decodable>(model: T.Type, from route: RouteProvider) async throws -> T
    
}

final class APIManager: APIHandler {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func perform<T: Decodable>(model: T.Type, from route: RouteProvider) async throws -> T {
        let (data, response) = try await self.session.data(for: buildRequest(from: route))
        do {
            try handleResponse(data: data, response: response)
            return try self.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.dataConversionFailure
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    private func buildRequest(from route: RouteProvider) throws -> URLRequest {
        let component = try buildUrlComponent(from: route)
        
        guard let url = component.url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        if !route.headers.isEmpty {
            request.allHTTPHeaderFields = route.headers
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func buildUrlComponent(from route: RouteProvider) throws -> URLComponents {
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = APIConstants.host
        components.path = APIConstants.basePath + route.path
        
        if case .get(let params) = route.method, !params.isEmpty {
            components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        
        return components
    }
    
}
