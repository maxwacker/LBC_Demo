//
//  ProductRecord.swift
//  
//
//  Created by maxime wacker on 23/03/2021.
//

import Foundation

// WARNING :
// Maybe Category definitions may change in the futur
// (since they are defined through a web service)
// Anyway this kind of change is supposed to be very rare and very business critical.
// So we accept that categories are hardcoded this way in the app, making the
// code more swifty
enum ProductCategory: Int {
    case _unknown_ // rawvalue 0
    case vehicle
    case Mode
    case diy
    case home
    case entertainment
    case property
    case books_cd_dvd
    case multimedia
    case service
    case pet
    case kid
}

extension ProductCategory: Decodable {
    public init(from decoder: Decoder) throws {
        let jsonIntID = try decoder.singleValueContainer().decode(Int.self)
        self = ProductCategory(rawValue: jsonIntID) ?? ._unknown_
    }
}

public struct ProductRecord {

    let id: UInt
    let category: ProductCategory
    let title: String
    let description: String
    let price: Decimal
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?
 
    internal init(id: UInt, category: ProductCategory, title: String, description: String, price: Decimal, creationDate: Date, isUrgent: Bool, siret: String?) {
        self.id = id
        self.category = category
        self.title = title
        self.description = description
        self.price = price
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.siret = siret
    }
}

extension ProductRecord: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case category_id
        case title
        case description
        case price
        case creation_date
        case is_urgent
        case siret
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UInt.self, forKey: .id)
        self.category = try container.decode(ProductCategory.self, forKey: .category_id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Decimal.self, forKey: .price)
        self.creationDate = try container.decode(Date.self, forKey: .creation_date)
        self.isUrgent = try container.decode(Bool.self, forKey: .is_urgent)
        self.siret = try? container.decode(String?.self, forKey: .siret)
    }
}
