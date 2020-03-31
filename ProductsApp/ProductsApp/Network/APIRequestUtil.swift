//
//  APIRequestUtil.swift
//  Global Paint
//
//  Created by Andreas Velounias on 01/09/2018.
//  Copyright © 2018 Andreas Velounias. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
typealias RequestCompletion = (_ response: Any?, _ error: Error?) -> Void

class APIRequestUtil {
  

    public static let BASE_URL = APPURL.BASE_URL

    public static func getProducts(params : String,completion: @escaping RequestCompletion) {
        
        GETRequest(url: API.GET_PRODUCTS,  params: params, completion: completion)
    }
    
    
   
    fileprivate static func GETRequest(url: String,params: String,
                                       completion: @escaping RequestCompletion) {
        
        let headers:[String : String]? = [:]
           
       
       
       let manager = Alamofire.SessionManager.default
       manager.session.configuration.timeoutIntervalForRequest = 50
       var request = URLRequest(url: URL(string: BASE_URL + url + params)!)
       request.allHTTPHeaderFields = headers
       
       request.httpMethod = "GET"
       
       manager.request(request).responseJSON { (response) in
           
           
           

           if response.result.isSuccess {
               
               completion(response.result.value, nil)
               
           }else {
               completion(nil, response.result.error)
               
           }
       }
   }
}
