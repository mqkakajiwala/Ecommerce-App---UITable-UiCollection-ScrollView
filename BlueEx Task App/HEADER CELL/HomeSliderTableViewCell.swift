//
//  HomeSliderTableViewCell.swift
//  BlueEx Task App
//
//  Created by Mustafa on 29/12/2018.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

class HomeSliderTableViewCell: UITableViewCell {
    
    //MARK: - Declare Properties here ..
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    //MARK: - Declare instance variable here ..
    var slides: [SlidingContentView] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupSlidingScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        self.contentView.bringSubviewToFront(pageControl)
        
    }
    
    func createSlides(imagesArray: [DataModel.Home_Header]) -> [SlidingContentView] {
        var array: [SlidingContentView] = []
        
        for i in 0..<imagesArray.count {
           let slide: SlidingContentView = Bundle.main.loadNibNamed("SlidingContentView", owner: self, options: nil)?.first as! SlidingContentView
            slide.slidingImageView.image = imagesArray[i].headerImage
            
            array.append(slide)
        }

        return array
    }
    
    func setupSlidingScrollView(slides: [SlidingContentView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        scrollView.contentSize = CGSize(width: self.contentView.frame.size.width * CGFloat(slides.count), height: self.contentView.frame.size.height)
        
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: self.contentView.frame.size.width * CGFloat(i), y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension HomeSliderTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/self.contentView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        
    }
}
