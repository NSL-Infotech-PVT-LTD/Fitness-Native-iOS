//
//  ConnectionHandler.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionHandler: NSObject{
    
    class func jsonPOSTRequest (url: String, parameters: [String : Any], completion: @escaping (Any) -> Void)
    {
        let requestUrl = API_URLS.BASE_URL.rawValue + url
        let header = Common.getTokenURLHeader()
        
        
        print("url is \(requestUrl) and the params are \(parameters) with the header is \(header)")
        
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody,headers: header ).responseJSON { (response:DataResponse<Any>) in

            
            switch(response.result) {
            case .success(_):
                completion(response.result.value!)
                break
            case .failure(_):
                completion(response.result.error!)
                break
            }
            
        }
        
    }
    
    //Image Upload Request
    class func jsonUploadRequest (url: String, parameters: [String : Any], image:UIImage?, completion: @escaping (Any) -> Void)
    {
        let requestUrl = API_URLS.BASE_URL.rawValue + url
        let headers : HTTPHeaders = ["Content-type" : "multipart/form-data"]
        Alamofire.upload(multipartFormData:{ (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            if image != nil{
                let imgData = image?.jpegData(compressionQuality: 0.2)!
                multipartFormData.append(imgData!, withName: "profile_image",fileName: "file.jpg", mimeType: "image/*")
            }
            
        },
                         usingThreshold:UInt64.init(),
                         to:requestUrl,
                         method:.post,
                         headers:headers,
                         encodingCompletion: { (encodingResult) in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON(completionHandler: { (response) in
                                    completion(response.result.value!)
                                })
                            case .failure(let encodingError):
                                print(encodingError)
                                completion(encodingError)
                                break
                            }
        })
    }
    
//    class func jsonGETRequest(url: String, completion: @escaping (Any) -> Void)
//    {
//        var requestUrl = API_URLS.BASE_URL.rawValue + url //base URL
//        requestUrl = requestUrl.replacingOccurrences(of: "+", with: "%2B")
//
//        let header = Common.getTokenURLHeader()
//        Alamofire.request(requestUrl,method: .get,encoding: JSONEncoding.default, headers: header)
//            .responseJSON { (response: DataResponse<Any>) in
//                switch(response.result) {
//                case .success(_):
//                    completion(response.result.value!)
//
//                case .failure(_):
//                    print(response.result.error!)
//                    completion(response.result.error!)
//                    break
//                }
//        }
//    }
    
    
}
