//
//  ImageRef.swift
//  BusinessEntities
//
//  Created by maxime wacker on 26/03/2021.
//

import Foundation

public struct ImageRef {
    public let smallURL: String?
    public let thumbURL: String?
    
    init(smallURL: String?, thumbURL: String?) {
        self.smallURL = smallURL
        self.thumbURL = thumbURL
    }
}

extension ImageRef: Decodable {
    enum CodingKeys: String, CodingKey {
        case small
        case thumb
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.smallURL = try? container.decode(String.self, forKey: .small)
        self.thumbURL = try? container.decode(String.self, forKey: .thumb)
    }
}
