//
//  Common.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation

class Common{
    
    static func getTokenURLHeader() -> [String:String]{
        return
            ["Content-Type":  "application/x-www-form-urlencoded",
            "Authorization": "Bearer ".appending(UserDefaults.standard.value(forKey: "token") as? String ?? "")]
    }
    
}
