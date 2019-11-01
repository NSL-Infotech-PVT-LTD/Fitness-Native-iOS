//
//  AthleteLoginModel.swift
//  UTrain
//
//  Created by osx on 07/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation

struct AthleteLoginModel:Codable {
    var id   : Int?
    var name : String?
    var email : String?
    var phone : String?
    var address : String?
    var profile_image : String?
    var location : String?
    var latitude : String?
    var longitude : String?
    var business_hour_starts : String?
    var business_hour_ends : String?
    var bio : String?
   // var service_ids : String?
    var expertise_years : String?
    var hourly_rate : String?
    var portfolio_image : String?
    var params : String?
    var state : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
}
