//
//  NewsViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/10/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private static let threshold = 60 * 30
    private static let secondaryThreshold = 60 * 10
    
    let newsManager = NewsManager.sharedInstance
    
    let noNewsView: UIView!
    let toastView: UIView!
    var toastLabel: UILabel?
    var tableView: UITableView?
    var lastUpdatedTimestamp = Date.init(timeIntervalSince1970: 0)
    var refreshButton: UIBarButtonItem?
    
    
    required init?(coder aDecoder: NSCoder) {
        noNewsView = UIView()
        toastView = UIView()
        
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        noNewsView = UIView()
        toastView = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("title.news", comment: "News")
        self.tabBarItem = UITabBarItem.init(title: NSLocalizedString("tabLabel.news", comment: "News"), image: UIImage.init(named: "news-icon"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView.init()
        self.tableView?.allowsSelection = false
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        self.tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.tableView?.tableFooterView = UIView.init()
        self.view.addSubview(self.tableView!)
        
        NSLayoutConstraint(item: self.tableView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        self.refreshButton = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        self.navigationItem.rightBarButtonItem = refreshButton!
        
        self.setupNoNewsView()
        self.noNewsView.isHidden = self.newsManager.newsEvents.count > 0
        
        self.setupToastView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppearRefreshNews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNewsObeyCache), name: Notification.Name.applicationWillEnterForeground, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
         NotificationCenter.default.removeObserver(self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsManager.numberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        let newsInfo = self.newsManager.eventAtIndex(indexPath.row)
        cell.setupViewWithNewsInfo(newsInfo!)
        
        return cell
    }
    
    @objc private func refreshButtonTapped() {
        self.refreshButton?.isEnabled = false
        self.refreshNews(showToast: true)
    }
    
    private func viewDidAppearRefreshNews() {
        let difference = self.lastUpdatedTimestamp.timeIntervalSinceNow
        if -Int(difference) > NewsViewController.secondaryThreshold {
            refreshNews(showToast: false)
        }
        
    }
    
    @objc private func refreshNewsObeyCache() {
        let difference = self.lastUpdatedTimestamp.timeIntervalSinceNow
        if -Int(difference) > NewsViewController.threshold {
            refreshNews(showToast: false)
        }
        
    }
    
    @objc func refreshNews(showToast: Bool) {
        self.newsManager.refreshNews(withSuccess: { () -> (Void) in
            self.lastUpdatedTimestamp = Date.init()
            self.noNewsView.isHidden = (self.newsManager.newsEvents.count > 0)
            self.tableView?.reloadData()
            self.refreshButton?.isEnabled = true
            if showToast {
                self.showToast(withMessage: "News is up to date")
            }
        }) { () -> (Void) in
            self.refreshButton?.isEnabled = true
            if showToast {
                self.showToast(withMessage: "Could not refresh news")
            }
        }
    }
    
    // MARK - Private Functions
    
    private func showToast(withMessage message: String) {
        self.toastLabel?.text = message
        self.toastView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.toastView.frame = CGRect.init(x: 0, y: self.view.bounds.size.height - self.view.safeAreaInsets.bottom - 50, width: self.view.bounds.size.width, height: 50)
        }) { (complete) in
            UIView.animate(withDuration: 0.5, delay: 2, options: [.curveEaseInOut], animations: {
                self.toastView.frame = CGRect.init(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: 50)
                
            }, completion: { (complete) in
                self.toastView.isHidden = true
            })
        }
    }
    
    private func setupToastView() {
        self.toastView.backgroundColor = UIColor.clear
        
        let backgroundView = UIView.init()
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.8
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.frame = self.toastView.bounds
        self.toastView.addSubview(backgroundView)
        
        self.toastLabel = UILabel.init()
        toastLabel?.font = UIFont.systemFont(ofSize: 16)
        toastLabel?.textColor = UIColor.white
        toastLabel?.textAlignment = .center
        toastLabel?.frame = self.toastView.frame
        toastLabel?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.toastView.addSubview(toastLabel!)
        
        self.toastView.frame = CGRect.init(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: 50)
        self.toastView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.view.addSubview(self.toastView)
        
        self.toastView.isHidden = true
        
    }
    
    private func setupNoNewsView() {
        
        self.noNewsView.backgroundColor = UIColor.white
        
        self.noNewsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.noNewsView)
        NSLayoutConstraint(item: self.noNewsView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.noNewsView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.noNewsView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.noNewsView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        let imageView = UIImageView.init(image: UIImage.init(named: "wisteria"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.noNewsView.addSubview(imageView)
        
        NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.noNewsView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.noNewsView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        let titleLabel = UILabel.init()
        titleLabel.text = "Stay Tuned!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noNewsView.addSubview(titleLabel)
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.noNewsView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.noNewsView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1, constant: -10).isActive = true
        
        let subtitle = UILabel.init()
        subtitle.text = "Come back later\nor\nrefresh the page."
        subtitle.numberOfLines = 0
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.textAlignment = .center
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        self.noNewsView.addSubview(subtitle)
        
        NSLayoutConstraint(item: subtitle, attribute: .leading, relatedBy: .equal, toItem: self.noNewsView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: subtitle, attribute: .trailing, relatedBy: .equal, toItem: self.noNewsView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: subtitle, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
    }
}
