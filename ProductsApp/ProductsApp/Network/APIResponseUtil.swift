//
//  File.swift
//  Global Paint
//
//  Created by Andreas Velounias on 01/09/2018.
//  Copyright © 2018 Andreas Velounias. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class APIResponseUtil {
    
    public static func isValidResponse(viewController: UIViewController,
                                       response: Any?, error: Error?, renderError: Bool = false,
                                       dismissLoading: Bool = true) -> Bool {
        
        var isValidResponse = false
        
       
        
        
        if response != nil {
            
            let json = JSON(response!)
            let dic = json.dictionary
            
            print(json)
            
            let status = dic!["Success"]?.boolValue
            
            if(status!)
            {
                
                isValidResponse = true
                
            }else{
                
                var error = ""
                
                if let err = dic!["Error"]?.array{
                    error = err[0].stringValue
                }
                
                if let err = dic!["Error"]?.stringValue{
                    error = err
                }
                
                if let err = dic!["Message"]?.stringValue{
                    error = err
                }
                
                if let err = dic!["Errors"]?.array{
                    if(err.count>0){
                        error = err[0].stringValue
                    }
                }
            }
                isValidResponse = false
                
        }
        
        return isValidResponse
    }
    
}


