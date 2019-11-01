//
//  API.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

@objc protocol APIsDelegate {
    func callBackFromAPI()
}


class API: NSObject{
    
   var delegate : APIsDelegate? //protocol's variable
    
//    static let shared = API()
//    override private init(){}
    
    
    func createAccount(url: String, params : [String:Any],image : UIImage, viewController : UIViewController, completion: @escaping ([String:Any]) -> Void){
        ConnectionHandler.jsonUploadRequest(url: url, parameters: params, image: image) { (result:Any) in
        
        //ConnectionHandler.jsonPOSTRequest(url: url, parameters: params) { (result:Any) in
            print("theeeeeeee\(result)")
            self.delegate?.callBackFromAPI()
            if ((result as? [String:Any]) != nil) {
                
                let response = result as! [String : Any]
                if (response["status"] as? Int ?? 0) == 1
                {
                    let data = response["data"] as? [String:Any]
                    let message = data?["Message"] as? String ?? ""
                    viewController.alertWindow(message: message)
                    do{
                        completion(response)
                        
                    }catch
                        let err{
                            print("Failed to Serialize the json data due to \(err)")
                    }
                }
                else{
                    let error = response["error"] as? [String :Any]
                    let err_msg = error?["error_message"] as? [String:Any]
                    let displayMessage = err_msg?["message"] as? [String] ?? [""]
                    let orgMessage = displayMessage[0]
                    viewController.alertWindow(message: orgMessage)

                    
                }
            }
            else {
                print("Empty response.....")
                
            }
        }
}
    //Login
    func loginUser(url: String, params : [String : Any], viewController : UIViewController, completion: @escaping (AthleteLoginModel) -> Void){
        
        ConnectionHandler.jsonPOSTRequest(url: url, parameters: params) { (result:Any) in
              self.delegate?.callBackFromAPI()
            
            if ((result as? [String : Any]) != nil) {
                
                let response = result as! [String : Any]
                print("the responseeeeeee\(response)")
                
                if (response["status"] as? Int ?? 0) == 1
                {
                    let data = response["data"] as? [String:Any] ?? [:]
                    let token = data["token"] as? String ?? ""
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    let user = data["user"] as? [String:Any]
                    let id = user?["id"] as? Int ?? 1
                    UserDefaults.standard.set("\(id)", forKey: "id")
                    do{
                        
                    let dataObject = try JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
                        
                        let loginModel = try JSONDecoder().decode(AthleteLoginModel.self, from: dataObject)
                        completion(loginModel)
                        
                    }catch let err{
                        print("Failed to Serialize the json data due to \(err)")
                    }
                }
                else{
                    let error = response["error"] as? [String:Any] ?? [:]
                    let errorMessage = error["error_message"] as? [String:Any] ?? [:]
                    let message = errorMessage["message"] as? [String] ?? [""]
                    let mainMessage = message[0] 
                    viewController.alertWindow(message: mainMessage)
                }
            }
            else {
               viewController.alertWindow(message: " Server Error ")
                
            }
        }
    }
    
    
    func forgetPassword(url: String, params : [String : Any],viewController : UIViewController, completion: @escaping ([String:Any]) -> Void){
        
        // let header = CommonMethods.getTokenURLHeader()
        ConnectionHandler.jsonPOSTRequest(url: url, parameters: params) { (result:Any) in
             self.delegate?.callBackFromAPI()
            
            if ((result as? [String : Any]) != nil) {
                
                let response = result as! [String : Any]
                
                if (response["status"] as? Int ?? 0) == 1
                {
                    let data = response["data"] as? [String:Any] ?? [:]
                    let message = data["messsage"] as? String ?? ""
                    viewController.alertWindow(message: message)
                    do{
                        
                        completion(response)
                        
                        
                    }catch let err{
                        print("Failed to Serialize the json data due to \(err)")
                    }
                }
                else{
                    let error = response["error"] as? [String:Any] ?? [:]
                    let errorMessage = error["error_message"] as? [String:Any] ?? [:]
                    let message = errorMessage["message"] as? [String] ?? [""]
                    let mainMessage = message[0]
                    viewController.alertWindow(message: mainMessage)
                }
            }
            else {
                print("Empty response")
            }
        }
    }
    
    
    func getServices(url: String, params : [String : Any], viewController : UIViewController, completion: @escaping ([ServicesModel]) -> Void){
        
        ConnectionHandler.jsonPOSTRequest(url: url, parameters: params) { (result:Any) in
            self.delegate?.callBackFromAPI()
            
            if ((result as? [String : Any]) != nil) {
                
                let response = result as! [String : Any]
                print("the responseeeeeee\(response)")
                
                if (response["status"] as? Int ?? 0) == 1
                {
                    let data = response["data"] as? [[String:Any]] ?? [[:]]
                   
                    do{
                        
                        let dataObject = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        
                        let loginModel = try JSONDecoder().decode([ServicesModel].self, from: dataObject)
                        completion(loginModel)
                        
                    }catch let err{
                        print("Failed to Serialize the json data due to \(err)")
                    }
                }
                else{
                    
                    viewController.alertWindow(message: "Empty Data")
                }
            }
            else {
                viewController.alertWindow(message: " Server Error ")
                
            }
        }
    }
    
}
