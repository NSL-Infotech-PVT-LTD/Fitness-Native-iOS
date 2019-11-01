//
//  ServicesModel.swift
//  UTrain
//
//  Created by osx on 15/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation

struct ServicesModel:Codable{
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
