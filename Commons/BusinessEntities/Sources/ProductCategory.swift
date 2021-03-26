//
//  ProductCategory.swift
//  BusinessEntities
//
//  Created by maxime wacker on 26/03/2021.
//

// WARNING :
// The fact that categories definition is given by remote JSON Data
// may indicate that this definition may change on backend side while the is running.
// But since this type of app-runtime changes on app model data, would require some huge effort
// to be done correctly (atomically) to avoid in-app data inconsistencies, we decide, as 1st implementation
// that category definition changes will require a new app version submission.
// So it is OK to store a static definition of categories like we do here :
public enum ProductCategory: Int {
    case _unknown_ // rawvalue 0
    case vehicle
    case mode
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
