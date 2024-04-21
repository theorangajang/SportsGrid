//
//  APIProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Combine
import Foundation

public protocol APIHandler {
    
    func perform<T: Decodable>(model: T.Type, from route: RouteProvider) async throws -> T
    
}

public final class APIManager: APIHandler {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let requestBuilder: RequestBuilder
    
    public init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = .init(),
        requestBuilder: RequestBuilder = RequestBuilder()
    ) {
        self.session = session
        self.decoder = decoder
        self.requestBuilder = requestBuilder
    }
    
    public  func perform<T: Decodable>(model: T.Type, from route: RouteProvider) async throws -> T {
        let (data, response) = try await self.session.data(for: buildRequest(from: route))
        do {
            return try handleResponse(model: model, data: data, response: response)
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }

//    public func perform<T: Decodable>(model: T.Type, from route: RouteProvider) -> AnyPublisher<T, Error> {
//        guard let request = try? buildRequest(from: route) else {
//            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
//        }
//        return self.session.dataTaskPublisher(for: request)
//            .tryMap { [weak self] (data, response) -> T in
//                guard let strongSelf = self else { throw NetworkError.dataConversionFailure }
//                return try strongSelf.handleResponse(data: data, response: response)
//            }
//            .eraseToAnyPublisher()
//    }
    
    private func handleResponse<T: Decodable>(model: T.Type, data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.dataConversionFailure
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
        do {
            return try self.decoder.decode(model.self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }
    
    private func buildRequest(from route: RouteProvider) throws -> URLRequest {
        try self.requestBuilder
            .addUrlComponents(from: route)
            .build(from: route)
    }
    
}
