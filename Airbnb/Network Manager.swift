//
//  Network Manager.swift
//  Airbnb
//
//  Created by Suraj Sharma on 30/01/24.

import Foundation


import Foundation

enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

protocol ApiHandleDelegate: ApiHandler {
    static func fetchHotelList(url: URL) async throws -> Data
}

protocol ResponseHandlerDelegate: ResponseHandler {
    static func decodeResponse<T: Decodable>(data: Data) async throws -> [T]
}

class NetworkManager {
    let apihandlers: ApiHandleDelegate
    let responseHandlers: ResponseHandlerDelegate
    
    init(apiHandlers: ApiHandleDelegate = ApiHandler(), responseHandlers: ResponseHandlerDelegate = ResponseHandler()) {
        self.apihandlers = apiHandlers
        self.responseHandlers = responseHandlers
    }
    
    func fetchData<T: Decodable>(urls: String, completion: @escaping (Result<[T], DemoError>) -> Void) async {
        guard let url = URL(string: urls) else {
            return completion(.failure(.BadURL))
        }
        
        do {
            let hotelData = try await ApiHandler.fetchHotelList(url: url)
            let decodedResponse: [T] = try await ResponseHandler.decodeResponse(data: hotelData)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(.NoData))
        }
    }
}


class ApiHandler: ApiHandleDelegate {
    static func fetchHotelList(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

class ResponseHandler: ResponseHandlerDelegate {
    static func decodeResponse<T: Decodable>(data: Data) async throws -> [T] {
        return try JSONDecoder().decode([T].self, from: data)
    }
}
