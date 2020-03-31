//
//  ProductsAppTests.swift
//  ProductsAppTests
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import ProductsApp

class ProductsAppTests: XCTestCase {

    var product = ProductsModel()
    //Suppose Api response for test case
    let dict:[String:String] = ["id": "0009468c-33e9-11e7-b485-02859a19531d",
        "title" : "Borsao Macabeo",
        "description": "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish."]
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProduct(){
        
        produuctApiResponse()
        checkDataModels()
        cacheCheck()

    }
    
    
     func cacheCheck(){
        SavePersistantData.saveProduct(product: self.product) //Saving product
        
        XCTAssert(FetchPersistentData.isAlreadyExist(id: product.ID, entityName: "Products", fieldName: "id")) // Check if product there in core data  after product Saved by checking id
        
    }
    
    func checkDataModels(){
        let json = JSON(dict)
        self.product = ProductsModel.init(withDictionary: json.dictionaryValue)
        XCTAssert(!product.ID.isEmpty) //Checking first value id is correctedly passed?
    }
    
    
    func produuctApiResponse() {
        let e = expectation(description: "success")
        
        let expectedSuccess = "success"
        APIRequestUtil.getProducts(params: "?includes[]=categories&includes[]=attributes&image_sizes[]=\(UIScreen.main.bounds.width)") { (result, error) in
            if(result != nil) {
                let swiftyJsonVar = JSON(result!)
                if swiftyJsonVar.count > 0{
                    XCTAssertEqual("success", expectedSuccess)
                }
                else{
                    XCTAssertEqual("fail", expectedSuccess)

                }
            }
           
            e.fulfill()

        }
        waitForExpectations(timeout: 30.0, handler: nil) //Wait for api response
    }
}
