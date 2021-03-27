//
//  ProductListNetWorker.swift
//  LBC_Demo
//
//  Created by maxime wacker on 27/03/2021.
//

import BusinessEntities

// FIXME : Should put in Commons/NetworkHelper
extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

final class ProductListNetWorker: ProductListNetWorking {
    private let _serviceURL: URL
    private let session = URLSession(configuration: .default)

    
    init(serviceURL: URL? = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")) {
        self._serviceURL = serviceURL!
    }
    
    func load(handler: @escaping (Result<[ProductRecord], Error>) -> Void) {
        let task = session.dataTask(with: _serviceURL){ (result) in
            switch result {
            case .success( (_, let data) ):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 //FIXME: Should be Worker property
                do {
                    let productList: [ProductRecord] = try decoder.decode([ProductRecord].self, from: data)
                    handler(.success(productList))
                } catch {
                    handler(.failure(error))
                }
                break
            case .failure(let error):
                handler(.failure(error))
                break
            }
        }
        task.resume()
    }
    
}
