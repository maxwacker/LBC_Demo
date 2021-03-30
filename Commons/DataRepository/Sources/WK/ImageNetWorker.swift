//
//  ImageNetWorker.swift
//  DataRepository
//
//  Created by maxime wacker on 30/03/2021.
//
import Foundation

final class ImageLoader:ImageLoading {
    private let session = URLSession(configuration: .default)

    func load(url: NSURL,handler: @escaping (Result<NSData, Error>) -> Void) {
        let task = session.dataTask(with: url as URL){ (result) in
            switch result {
            case .success( (_, let data) ):
                handler(.success(data as NSData))
                break
            case .failure(let error):
                handler(.failure(error))
                break
            }
        }
        task.resume()
    }
}
