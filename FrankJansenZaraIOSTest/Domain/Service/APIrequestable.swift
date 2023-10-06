//
//  APIrequestable.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 9/3/10/23.
//

import Foundation
import Network

class APIRequestable {
    
    enum APIError: LocalizedError {
        case noInternet
        case malformed(String)
        case underlying(Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternet: return "No internet connection"
            case let .malformed(url): return "The URL ( \(url) ) is malformed"
            case let .underlying(error): return "Underlying: \(error.localizedDescription)"
            }
        }
    }
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "networkMonitor")
    var isConnected = true
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
    
    func request<T : Decodable>(service: Service, modelType: T.Type) async throws -> T {
        guard isConnected else {
            throw APIError.noInternet
        }
        
        guard let url = service.url else {
           throw APIError.malformed(service.fullPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        
        do {
            
            print("url \(request.url?.absoluteString ?? "")")
            let (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            print(statusCode)
            let str = String(data: data, encoding: .utf8)!
            print(str)
            let decoder = JSONDecoder()
            guard 200..<300 ~= statusCode else {
                let errorModel = try decoder.decode(APIErrorResponse.self, from: data)
                throw errorModel
            }

            let model = try decoder.decode(modelType.self, from: data)
            return model
        }
        catch let error as APIErrorResponse {
            print(error)
            throw error
        }
        catch {
            print(error)
            throw APIError.underlying(error)
        }
    }
}

struct APIErrorResponse: Decodable, LocalizedError {
    
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case error
    }
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: CodingKeys.self)
        errorDescription = try outerContainer.decodeIfPresent(String.self, forKey: .error)
    }
}

