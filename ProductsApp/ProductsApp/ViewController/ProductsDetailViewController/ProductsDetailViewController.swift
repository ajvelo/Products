//
//  ProductsDetailViewController.swift
//  ProductsApp
//
//  Created by Andreas Velounias on 27/03/2020.
//  Copyright © 2020 Andreas Velounias. All rights reserved.
//

import UIKit

class ProductsDetailViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionProductsView: UICollectionView!
    @IBOutlet weak var pageControlView: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblAgeRestrictions: UILabel!
    @IBOutlet weak var lblIsForSale: UILabel!
    @IBOutlet weak var collectionTageView: UICollectionView!
    @IBOutlet weak var tableAttributesView: UITableView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var collectionTagView: UICollectionView!
    @IBOutlet weak var layoutHeightAttributes: NSLayoutConstraint!
    
    
    @IBOutlet weak var layoutTagsView: NSLayoutConstraint!
    var product = ProductsModel()
    var stretchyConstraints: [NSLayoutConstraint]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateData()
        self.collectionTagView?.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Functions
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let size = change?[NSKeyValueChangeKey.newKey] as? CGSize {
            layoutTagsView.constant = size.height
        }
    }
    
    
    func populateData(){
        lblTitle.text = product.titles
        lblPrice.text = "Price $\(product.listPrices)"
        lblDesc.text = product.descriptions
        if product.ageRestricted{
            lblAgeRestrictions.text = "Age Restricted"
        }
        else{
            lblAgeRestrictions.text = "No Age Restriction"
        }
        if product.isForSale{
            lblIsForSale.text = "For Sale"
        }
        else{
            lblIsForSale.text = "Not For Sale"
        }
        layoutHeightAttributes.constant = CGFloat(80 * product.arrAttributes.count)
        
    }
    
    // MARK: - TableView Delegate
       func numberOfSectionsInTableView(tableView: UITableView) -> Int
       {
           return 1
       }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.arrAttributes.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          tableView.register(UINib(nibName: String(describing: AttributesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AttributesTableViewCell.self))
        
          
          let cell : AttributesTableViewCell! = tableView.dequeueReusableCell(withIdentifier: String(describing: AttributesTableViewCell.self)) as? AttributesTableViewCell
        let obj = product.arrAttributes[indexPath.row]
        cell.lblTitle.text = obj.titles
        cell.lblUnit.text = obj.unit
        cell.lblValue.text = obj.value
         
          return cell
          
      }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      }
      
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 0
      }
      
     
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 80
      }
          

  // MARK: - Collection Delegate
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        if collectionView == collectionProductsView{
            return product.image.count
        }
        else{
            return product.tags.count
        }
        
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
          collectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        collectionView.register(UINib(nibName: "DetailCell", bundle: nil), forCellWithReuseIdentifier: "DetailCell")
        if collectionView == collectionProductsView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath as IndexPath) as! DetailCell
            AppUtility.loadImage(imageView: cell.imageProductView, urlString: product.image[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath as IndexPath) as! TagCollectionViewCell
            cell.lblTitle.text = product.tags[indexPath.row]
            return cell
        }
          
     }
      func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
      {
        if collectionView == collectionProductsView{
            self.createStretchyImageConstraintsOnCell(imageCell: cell as! DetailCell)

        }
      }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
     {
     }
      
      public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
      {
        if collectionView == collectionProductsView{
            return CGSize (width: collectionView.frame.width, height: collectionView.frame.size.height)
        }
        else{
            let additonalSpace : CGFloat = 20
            
                let itemSize = product.tags[indexPath.row].size(withAttributes: [
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
                return CGSize(width: itemSize.width + additonalSpace,  height: 40)
            }
            
        }
        
  
    func createStretchyImageConstraintsOnCell(imageCell:DetailCell)
    {
        
        // Disable current image top constraint and prepare image
       imageCell.imageTopConstraint.isActive = false
        imageCell.clipsToBounds = false
        imageCell.contentMode = UIView.ContentMode.scaleAspectFill
        
        // Create array to store constraints
        stretchyConstraints = []
        
        // Now create a constraint from the image to the topLayout guide so that it sticks to it
        // The image must also be setup with aspect fill so the image stretches
        let stretchyConstraint = NSLayoutConstraint(
            item: imageCell.imageProductView!,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.topLayoutGuide,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1.0,
            constant: 0.0)
        stretchyConstraint.priority = UILayoutPriority(rawValue: 250)
        stretchyConstraints!.append(stretchyConstraint)
        
        // This constraint allows you to push the scroll up and not squash the image
        let squashyConstraint = NSLayoutConstraint(
            item: imageCell.imageProductView!,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual,
            toItem: self.collectionProductsView,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1.0,
            constant: 0.0)
        stretchyConstraints!.append(squashyConstraint)
        
        // Add the constraints
        self.view.addConstraints(stretchyConstraints!)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.collectionProductsView.reloadData()

    }

}
