//
//  ProfileInfoViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 12/16/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit
import Pulley

class ProfileInfoViewController: UIViewController {
    private let chipArrowDown = UIImage.init(named: "expand-arrow")
    private let chipArrowFlat = UIImage.init(named: "expand-flat")
    private let scrollView = UIScrollView.init()
    
    var speakerInfo: SpeakerInfo!
    
    var offsetBottom: CGFloat!
    
    lazy var tabView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = chipArrowFlat
        
        return view
    }()
    
    convenience init(speakerInfo: SpeakerInfo, offsetBottom: CGFloat) {
        self.init(nibName: nil, bundle: nil)
        
        self.speakerInfo = speakerInfo
        self.offsetBottom = offsetBottom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabView)
        NSLayoutConstraint.activate([ tabView.topAnchor.constraint(equalTo: view.topAnchor), tabView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 44, right: 0)
        
        view.addSubview(scrollView)
        NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: tabView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        let name = UILabel.init()
        scrollView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = speakerInfo.name
        name.font = UIFont.boldSystemFont(ofSize: 24)
        NSLayoutConstraint.init(item: name, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: name, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: name, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        
        let title = UILabel.init()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = speakerInfo.title
        title.font = UIFont.systemFont(ofSize: 14)
        self.addLabelToScrollView(scrollView: scrollView, label: title, belowLabel: name, offset: 0)
        
        var lastView: UIView = title
        
        let affiliation = UILabel.init()
        affiliation.translatesAutoresizingMaskIntoConstraints = false
        affiliation.text = speakerInfo.temple
        affiliation.font = UIFont.systemFont(ofSize: 14)
        self.addLabelToScrollView(scrollView: scrollView, label: affiliation, belowLabel: lastView, offset: 0)
        lastView = affiliation
        
        if let validBirthplace = speakerInfo.birthplace {
            let birthplaceTitle = UILabel.init()
            birthplaceTitle.translatesAutoresizingMaskIntoConstraints = false
            birthplaceTitle.text = "Birthplace"
            birthplaceTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.addLabelToScrollView(scrollView: scrollView, label: birthplaceTitle, belowLabel: lastView, offset: 10)
            
            let birthplaceInfo = UILabel.init()
            birthplaceInfo.translatesAutoresizingMaskIntoConstraints = false
            birthplaceInfo.text = validBirthplace
            birthplaceInfo.font = UIFont.systemFont(ofSize: 14)
            self.addLabelToScrollView(scrollView: scrollView, label: birthplaceInfo, belowLabel: birthplaceTitle, offset: 0)
            lastView = birthplaceInfo
        }
        
        let backgroundTitle = UILabel.init()
        backgroundTitle.translatesAutoresizingMaskIntoConstraints = false
        backgroundTitle.text = "Background"
        backgroundTitle.font = UIFont.boldSystemFont(ofSize: 18)
        self.addLabelToScrollView(scrollView: scrollView, label: backgroundTitle, belowLabel: lastView, offset: 10)
        lastView = backgroundTitle
        
        let backgroundInfo = UILabel.init()
        backgroundInfo.translatesAutoresizingMaskIntoConstraints = false
        backgroundInfo.numberOfLines = 0
        backgroundInfo.text = speakerInfo.background
        backgroundInfo.font = UIFont.systemFont(ofSize: 14)
        self.addLabelToScrollView(scrollView: scrollView, label: backgroundInfo, belowLabel: lastView, offset: 0)
        lastView = backgroundInfo
        
        if speakerInfo.facts != nil {
            for speakerFact in speakerInfo.facts! {
                
                let factTitle = UILabel.init()
                factTitle.translatesAutoresizingMaskIntoConstraints = false
                factTitle.numberOfLines = 0
                factTitle.text = speakerFact.title
                factTitle.font = UIFont.boldSystemFont(ofSize: 18)
                self.addLabelToScrollView(scrollView: scrollView, label: factTitle, belowLabel: lastView, offset: 10)
                
                let factInfo = UILabel.init()
                factInfo.translatesAutoresizingMaskIntoConstraints = false
                factInfo.numberOfLines = 0
                factInfo.text = speakerFact.description
                factInfo.font = UIFont.systemFont(ofSize: 14)
                self.addLabelToScrollView(scrollView: scrollView, label: factInfo, belowLabel: factTitle, offset: 0)

                lastView = factInfo
            }
        }
        
        NSLayoutConstraint.init(item: lastView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: -offsetBottom).isActive = true
        
        self.scrollView.isUserInteractionEnabled = false
    }
    
    private func addLabelToScrollView(scrollView: UIScrollView, label: UILabel, belowLabel: UIView, offset: CGFloat) {
        scrollView.addSubview(label)
        NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: belowLabel, attribute: .bottom, multiplier: 1.0, constant: offset).isActive = true
        NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: belowLabel, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: belowLabel, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
    }
}

extension ProfileInfoViewController: PulleyDrawerViewControllerDelegate {
    public func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        let expanded = (drawer.drawerPosition == PulleyPosition.open)
        tabView.image = expanded ? chipArrowDown : chipArrowFlat
       
        if !expanded {
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
        
        self.scrollView.isUserInteractionEnabled = expanded
    }
    
    public func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        let height = self.view.bounds.size.height - 500
        return max(height, 150)
    }
    
    public func supportedDrawerPositions() -> [PulleyPosition] {
        return [.open, .collapsed, .closed]
    }
}
