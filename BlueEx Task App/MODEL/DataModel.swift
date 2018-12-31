//
//  DataModel.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct DataModel {
    struct Home_Header {
        var headerImage: UIImage?
        
        init(_ dict: [String: String]) {
            self.headerImage = Constants.Helper.getImageFromURL(dict["image"]!)
        }
        
        //MARK: - Convert Image from String
        func getImageFromURL(_ imagePath: String) -> UIImage? {
            do {
                let url = URL(string: imagePath)
                let data = try? Data(contentsOf: url!)
                return UIImage(data: data!)
                
            }
        }
    }
    
    
    struct Special_Categories {
        var titleText: String?
        var imageUrl: String?
        
        init(_ dict: [String: String]) {
            self.titleText = dict["text"]
            self.imageUrl =  dict["image"]
        }
        
    }
    
    struct Artistic_Carousel {
        var avatarImage: UIImage?
        var productName: String?
        var actualPrice: String?
        var discountPrice: String?
        
        init(_ dict: [String: String]) {
            self.avatarImage = Constants.Helper.getImageFromURL(dict["productimage"]!)
            self.productName = dict["productname"]
            self.actualPrice = dict["actualprice"]
            self.discountPrice = dict["discountprice"]
        }
        
    }
}
