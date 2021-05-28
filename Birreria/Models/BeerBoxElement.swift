//
//  BeerBoxElement.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 27/05/21.
//

import Foundation

struct BeerBoxElement : Codable {
    let id : Int?
    let name : String?
    let imageUrl : String?
    let tagline : String?
    let descriptionField : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageUrl = "image_url"
        case tagline = "tagline"
        case descriptionField = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
    }
    
}
