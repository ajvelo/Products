//
//  ProductsViewControllerViewController.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import UIKit
import SwiftyJSON
class ProductsViewControllerViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var viewSearchField: UIView!
    @IBOutlet weak var tableProductsView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    var arrProducts = Array<ProductsModel>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewSearchField.transform = CGAffineTransform(translationX: +self.viewSearchField.frame.size.width , y: self.viewSearchField.bounds.origin.y)
        arrProducts = FetchPersistentData.getProducts()
        tableProductsView.reloadData()
        if AppUtility.isReachable(){
            getProducts()

        }
       
    }


    //MARK:- UIActions
    @IBAction func searchTapped(_ sender: Any) {
       UIView.animate(withDuration: 0.3) {
           self.viewSearchField.transform = .identity
           self.tfSearch.becomeFirstResponder()

       }
   }
   
   

   @IBAction func dismissSearchTapped(_ sender: Any) {
       UIView.animate(withDuration: 0.3) {
           self.viewSearchField.transform = CGAffineTransform(translationX: +self.viewSearchField.frame.size.width , y: self.viewSearchField.bounds.origin.y)
           
           self.tfSearch.resignFirstResponder()

       }
    arrProducts  = FetchPersistentData.getProducts()
    tableProductsView.reloadData()
   }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfSearch {
            if (textField.text!.count + string.count) > 0 {
                
                if string.isEmpty && textField.text!.count == 1  {
                    arrProducts = FetchPersistentData.getProducts()
                    tableProductsView.reloadData()
                }
                else{
                    arrProducts = FetchPersistentData.getFilteredProducts(search:textField.text! +  string)
                    tableProductsView.reloadData()
                }
            }
            else{
                arrProducts = FetchPersistentData.getProducts()
                tableProductsView.reloadData()
            }
            
        }
        return true
    }
    //MARK:- APIS
    func getProducts(){
        APIRequestUtil.getProducts(params: "?includes[]=categories&includes[]=attributes&image_sizes[]=\(UIScreen.main.bounds.width)") { (result, error) in
            if(result != nil) {
                let swiftyJsonVar = JSON(result!)
                let arrDic =  swiftyJsonVar["data"].arrayValue
                self.arrProducts.removeAll()
                for dict in arrDic{
                    let product = ProductsModel.init(withDictionary: dict.dictionaryValue)
                    SavePersistantData.saveProduct(product: product)
                    self.arrProducts.append(product)
                }
                self.tableProductsView.reloadData()
                
            }
        }
    }

    
    
    // MARK: - TableView Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrProducts.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       tableView.register(UINib(nibName: String(describing: ProductsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductsTableViewCell.self))
       
       let cell : ProductsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductsTableViewCell.self)) as? ProductsTableViewCell
        let obj = arrProducts[indexPath.row]
        if obj.image.count > 0{

            AppUtility.loadImage(imageView: cell.imageClassesView, urlString: obj.image[0])
        }
        else{
            AppUtility.loadImage(imageView: cell.imageClassesView, urlString: "")
        }
        cell.lblPrice.text = "$\(obj.listPrices)"
        cell.lblTitle.text = obj.titles
    
       return cell
       
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = ProductsDetailViewController(nibName: String(describing: ProductsDetailViewController.self), bundle: nil)
    viewController.product = arrProducts[indexPath.row]
    self.navigationController?.pushViewController(viewController, animated: true)
       
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 200
   }
       
}
