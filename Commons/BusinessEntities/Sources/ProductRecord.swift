//
//  ProductRecord.swift
//  
//
//  Created by maxime wacker on 23/03/2021.
//

public struct ProductRecord {
    public let id: UInt
    public let category: ProductCategory
    public let title: String
    public let description: String
    public let price: Decimal
    public let imageRef: ImageRef
    public let creationDate: Date
    public let isUrgent: Bool
    public let siret: String?
 
    init(
        id: UInt,
        category: ProductCategory,
        title: String,
        description: String,
        price: Decimal,
        imageRef: ImageRef,
        creationDate: Date,
        isUrgent: Bool,
        siret: String? = nil) {
        self.id = id
        self.category = category
        self.title = title
        self.description = description
        self.price = price
        self.imageRef = imageRef
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
        case images_url
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
        self.imageRef = try container.decode(ImageRef.self, forKey: .images_url)
        self.creationDate = try container.decode(Date.self, forKey: .creation_date)
        self.isUrgent = try container.decode(Bool.self, forKey: .is_urgent)
        self.siret = try? container.decode(String?.self, forKey: .siret)
    }
}
