//
//  AppUtility.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import Foundation
import SDWebImage
import Alamofire

class AppUtility : NSObject {
    
    class func loadImage(imageView: UIImageView, urlString: String)->Swift.Void{
        let placeHolder = UIImage(named: "img_placeholder")
        imageView.image = placeHolder
        let encodedString:String = urlString.replacingOccurrences(of: " ", with: "%20")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: encodedString), placeholderImage: placeHolder)
    }
    
    class func isReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
