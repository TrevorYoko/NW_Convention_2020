//
//  CustomPhotoViewer.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/12/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class CustomPhotoViewer: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var imageUrls: [String] = []
    var pageControl: UIPageControl?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    convenience init(imageUrls: [String]) {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        self.init(collectionViewLayout: flowLayout)
        
        self.imageUrls.append(contentsOf: imageUrls)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView?.isPagingEnabled = true
        
        self.collectionView?.contentInsetAdjustmentBehavior = .never
        
        self.pageControl = UIPageControl.init()
        pageControl?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageControl!)
        
        NSLayoutConstraint.init(item: pageControl!, attribute: .centerX, relatedBy: .equal, toItem: collectionView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        pageControl?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pageControl?.numberOfPages = self.imageUrls.count
        pageControl?.addTarget(self, action: #selector(pageControlChanged(pageControl:)), for: .valueChanged)
    }
    
    // MARK - UICollectionView Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        if indexPath.row < self.imageUrls.count{
            cell.setupCellWithImageUrl(self.imageUrls[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = self.collectionView!.contentOffset.x / self.collectionView!.frame.size.width
        self.pageControl?.currentPage = Int(currentIndex)
    }
    
    
    // MARK - Private Functions
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func pageControlChanged(pageControl: UIPageControl) {
        let pageNumber = pageControl.currentPage
        self.collectionView?.scrollToItem(at: IndexPath.init(row: pageNumber, section: 0), at: .centeredHorizontally, animated: true)
    }
}
