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
    case COACH_LIST = "coach/list"
    case ORG_LIST = "organisers/list"
    case EVENT_LIST_ATHLETE = "events/athlete/list"
    case SPACES_LIST_ATHLETE = "spaces/athlete/list"
    case SESSIONS_LIST_ATHLETE = "session/athlete/list"

    
    case FORGOT_PASSWORD = "reset-password"
    case GET_SERVICE = "services"
    case CONFIRM_OTP = "comfirmOtp"
    case LOGIN = "login"
    
    case COACH_IMAGE_BASE_URL = "https://dev.netscapelabs.com/utrain/public/uploads/coach/profile_image/"
    
    case ORG_IMAGE_BASE_URL = "https://dev.netscapelabs.com/utrain/public/uploads/organiser/profile_image/"
    
    case EVENT_LIST_ATHLETE_URL = "https://dev.netscapelabs.com/utrain/public/uploads/events/"
    
    
    
}
