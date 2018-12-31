//
//  SpecialCategoriesTableViewCell.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

class SpecialCategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var myStackView: UIStackView!
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func createCustomButtons(_ array: [DataModel.Special_Categories]) {
//        for i in 0..<array.count {
//            print(array[i])
//            let button = UIButton()
//            button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            button.titleLabel?.text = array[i].titleText
//            button.setImage(getImageFromURL(array[i].imageUrl!), for: .normal)
//
//            self.myStackView.distribution = .fillProportionally
//
//            self.myStackView.addArrangedSubview(button)
//        }
        if array.count > 0 {
        firstBtn.setBackgroundImage(getImageFromURL(array[0].imageUrl!), for: .normal)
            firstLabel.text = array[0].titleText
//        firstBtn.setTitle(array[0].titleText, for: .normal)
        
        secondBtn.setBackgroundImage(getImageFromURL(array[1].imageUrl!), for: .normal)
            secondLabel.text = array[1].titleText
//        secondBtn.setTitle(array[1].titleText, for: .normal)
        
        thirdBtn.setBackgroundImage(getImageFromURL(array[2].imageUrl!), for: .normal)
            thirdLabel.text = array[2].titleText
//        thirdBtn.setTitle(array[2].titleText, for: .normal)
        
        fourthBtn.setBackgroundImage(getImageFromURL(array[3].imageUrl!), for: .normal)
            fourthLabel.text = array[3].titleText
//        fourthBtn.setTitle(array[3].titleText, for: .normal)
        }
    }
    
    func getImageFromURL(_ imagePath: String) -> UIImage? {
        let url = URL(string: imagePath)
        do {
            let data = try? Data(contentsOf: url!)
            return UIImage(data: data!)
        }
    }
    
    
}
