//
//  SpecialCategoriesTableViewCell.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

class SpecialCategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var specialCategoryCollectionView: UICollectionView!
    
    
    func createCustomButtons(_ array: [DataModel.Special_Categories]) {


//        if array.count > 0 {
//        firstBtn.setBackgroundImage(getImageFromURL(array[0].imageUrl!), for: .normal)
//            firstLabel.text = array[0].titleText
//
//        
//        secondBtn.setBackgroundImage(getImageFromURL(array[1].imageUrl!), for: .normal)
//            secondLabel.text = array[1].titleText
//
//        
//        thirdBtn.setBackgroundImage(getImageFromURL(array[2].imageUrl!), for: .normal)
//            thirdLabel.text = array[2].titleText
//
//        
//        fourthBtn.setBackgroundImage(getImageFromURL(array[3].imageUrl!), for: .normal)
//            fourthLabel.text = array[3].titleText
//
//        }
    }
    
    func getImageFromURL(_ imagePath: String) -> UIImage? {
        let url = URL(string: imagePath)
        do {
            let data = try? Data(contentsOf: url!)
            return UIImage(data: data!)
        }
    }
    
    
}
