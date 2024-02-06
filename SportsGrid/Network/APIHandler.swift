//
//  APIProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Combine
import Foundation

protocol APIHandler {
    
    func perform<T: Decodable>(model: T.Type, from route: RouteProvider) -> AnyPublisher<T, Error>
    
}

final class APIManager: APIHandler {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let requestBuilder: RequestBuilder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = .init(), requestBuilder: RequestBuilder = RequestBuilder()) {
        self.session = session
        self.decoder = decoder
        self.requestBuilder = requestBuilder
    }
    
    func perform<T: Decodable>(model: T.Type, from route: RouteProvider) -> AnyPublisher<T, Error> {
        guard let request = try? buildRequest(from: route) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return self.session.dataTaskPublisher(for: request)
            .tryMap { [weak self] (data, response) -> Data in
                guard let strongSelf = self else { throw NetworkError.dataConversionFailure }
                try strongSelf.handleResponse(data: data, response: response)
                return data
            }
            .flatMap { [weak self] data -> AnyPublisher<T, Error> in
                guard let strongSelf = self, let response = try? strongSelf.decoder.decode(T.self, from: data) else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
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
        try self.requestBuilder
            .addUrlComponents(from: route)
            .build(from: route)
    }
    
}
