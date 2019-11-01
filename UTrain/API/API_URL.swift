//
//  API_URL.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation

enum API_URLS : String {
    
    case BASE_URL = "https://dev.netscapelabs.com/utrain/public/api/"
}


enum API_ENDPOINTS : String {
    case SIGNUP_ATHLETE   = "athlete/register"
    case SIGNUP_COACH     = "coach/register"
    case SIGNUP_ORGANISER = "organiser/register"
    
    case FORGOT_PASSWORD = "reset-password"
    case GET_SERVICE = "services"
    case CONFIRM_OTP = "comfirmOtp"
    case LOGIN = "login"
    
    
    
}
