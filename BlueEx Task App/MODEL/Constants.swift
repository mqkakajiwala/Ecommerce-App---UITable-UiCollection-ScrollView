//
//  Constants.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct Constants {
    struct BASE_URL {
        static let url = "https://blueex.cloud/interblueexcod/homenonfood.php"
    }
    
    struct Helper {
        //MARK: - Convert Image from String
       static func getImageFromURL(_ imagePath: String) -> UIImage? {
            do {
                let url = URL(string: imagePath)
                let data = try? Data(contentsOf: url!)
                return UIImage(data: data!)
                
            }
        }
    }
}
