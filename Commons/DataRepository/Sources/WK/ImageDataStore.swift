//
//  ImageDataStore.swift
//  ProductListScene
//
//  Created by maxime wacker on 30/03/2021.
//

import Foundation
import ProductListScene

protocol ImageLoading {
    func load(url: NSURL,handler: @escaping (Result<NSData, Error>) -> Void)
}

final class ImageDataStore: ImageDataStoring {
    private let _imageLoader: ImageLoading
    private let _imageDataCache = NSCache<NSURL, NSData>()
    private var _loadingResponses = [NSURL: [(NSData?) -> Void]]()

    init(imageLoader: ImageLoading = ImageLoader()){
        self._imageLoader = imageLoader
    }
    
    final func getImageData(for url: NSURL, completion: @escaping (NSData?) -> Void) {
        // Check for a cached image.
        if let cachedImageData = _imageDataCache.object(forKey: url) {
            completion(cachedImageData)
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if _loadingResponses[url] != nil {
            _loadingResponses[url]?.append(completion)
            return
        } else {
            _loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        _imageLoader.load(url: url) { [weak self]
            (result: Result<NSData, Error>) in
            switch result {
            case .success (let responseData):
                self?._imageDataCache.setObject(responseData, forKey: url, cost: responseData.count)
                // Iterate over each requestor for the image and pass it back.
                for completion in self?._loadingResponses[url] ?? [] {
                    completion(responseData)
                }
            case .failure(let error):
                // FIXME : Handle Error properly
                print(error)
                completion(nil)
                break
            }
        }
    }
}
