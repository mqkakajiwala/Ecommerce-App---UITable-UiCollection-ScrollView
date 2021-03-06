//
//  ViewController.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class ViewController: UIViewController {
    
    //MARK: - Declare instance variables here ..
    var tableHeaderImagesModelArray = [DataModel.Home_Header]()
    var specialCategoriesModelArray = [DataModel.Special_Categories]()
    var articleCarouselModelArray = [DataModel.Artistic_Carousel]()
    
    
    //MARK: - Declare properties here ..
    @IBOutlet weak var homeTableView: UITableView! {
        didSet {
            self.homeTableView.delegate = self
            self.homeTableView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        configureTableView()
        getDataFromServer(url: Constants.BASE_URL.url)
    }
    
    //MARK: - Networking Methods
    func getDataFromServer(url: String) {
        SVProgressHUD.show()
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON: JSON = JSON(response.result.value!)
                self.setModelData(dataJSON)
                SVProgressHUD.dismiss()
            }else {
                print("Error getting data \(String(describing: response.result.error))")
                SVProgressHUD.dismiss()
            }
        }
    }
    
    //MARK: - Set Data into model
    func setModelData(_ data: JSON) {
        if let items = data["homeslider"].array {
            for item in items {
                tableHeaderImagesModelArray.append(DataModel.Home_Header(item.dictionaryObject as! [String: String]))
            }
        }
        
        if let items = data["specialcategories"].array {
            for item in items {
                specialCategoriesModelArray.append(DataModel.Special_Categories.init(item.dictionaryObject as! [String : String]))
            }
        }
        
        if let items = data["articlecarousel"][0]["productlist"].array {
            for item in items {
                articleCarouselModelArray.append(DataModel.Artistic_Carousel.init(item.dictionaryObject as! [String: String]))
            }
        }
        
        self.homeTableView.reloadData()
        
        
        
    }
    
    
    
    
}

//MARK: - Tableview data source methods ..
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSliderCell", for: indexPath) as! HomeSliderTableViewCell
            
            cell.slides = cell.createSlides(imagesArray: tableHeaderImagesModelArray)
            cell.awakeFromNib()
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCategoriesCell", for: indexPath) as! SpecialCategoriesTableViewCell
            
            cell.createCustomButtons(specialCategoriesModelArray)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "metroDealsCell", for: indexPath) as! MetroDealsTableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
    
}

//MARK: - Tableview delegate methods ..
extension ViewController: UITableViewDelegate {
    func configureTableView() {
        self.homeTableView.rowHeight = UITableView.automaticDimension
        self.homeTableView.estimatedRowHeight = homeTableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 2:
                return tableView.rowHeight + 100
            default:
                return tableView.rowHeight
            }
        }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if let cell = cell as? SpecialCategoriesTableViewCell {
                cell.specialCategoryCollectionView.isScrollEnabled = false
                cell.specialCategoryCollectionView.dataSource = self
                cell.specialCategoryCollectionView.delegate = self
                cell.specialCategoryCollectionView.reloadData()
            }
        } else if indexPath.row == 2 {
            if let cell = cell as? MetroDealsTableViewCell {
                cell.metroDealsCollectionView.dataSource = self
                //                cell.metroDealsCollectionView.delegate = self
                cell.metroDealsCollectionView.reloadData()
            }
        }
        
    }
}

//MARK: - CollectionView datasource methods ..
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView.viewWithTag(2) {
            return articleCarouselModelArray.count
        }else {
            return specialCategoriesModelArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView.viewWithTag(2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "metroDealsCollectionCell", for: indexPath) as! MetroDealsCollectionViewCell
            
            cell.productImageView.image = articleCarouselModelArray[indexPath.row].avatarImage
            cell.productName.text = articleCarouselModelArray[indexPath.row].productName
            cell.actualPrice.text = articleCarouselModelArray[indexPath.row].actualPrice
            cell.discountPrice.text = articleCarouselModelArray[indexPath.row].discountPrice
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialCategoryCell", for: indexPath) as! SpecialCategoriesCollectionViewCell
            cell.categoryButton.setImage(Constants.Helper.getImageFromURL(specialCategoriesModelArray[indexPath.row].imageUrl!), for: .normal)
            cell.categoryLabel.text = specialCategoriesModelArray[indexPath.row].titleText
            return cell
        }
    }
}


//MARK: - CollectionView delegate methods ..
extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView.viewWithTag(1) {
            
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 5.0
            
            let numberOfItemsPerRow: CGFloat = 4.0
            let itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
            
            return CGSize(width: itemWidth, height: itemWidth)
        }else {
            return CGSize()
        }
        
        
    }
    
}

