//
//  HotelMapViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 1/26/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class HotelMapViewController: UIViewController, UIScrollViewDelegate {
    let imageView = UIImageView.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Room Map"
        
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.black
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.contentInsetAdjustmentBehavior = .never
        
        self.view.addSubview(scrollView)
        
        self.imageView.image = UIImage.init(named: "HotelMap")
        imageView.clipsToBounds = false
        imageView.frame = scrollView.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.addSubview(imageView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
