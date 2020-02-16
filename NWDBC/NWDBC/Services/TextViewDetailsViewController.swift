//
//  TextViewDetailsViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 1/16/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class TextViewDetailsViewController: UIViewController {
    let textView: UITextView!
    
    init() {
        self.textView = UITextView.init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.textView.frame = self.view.bounds
        self.textView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.textView.font = UIFont.systemFont(ofSize: 18)
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false
        self.view.addSubview(self.textView)
        
        self.textView.scrollRangeToVisible(NSRange.init(location: 0, length: 1))
    }
    
    public func setupViewController(_ title: String, text: String) {
        self.setupViewController(title, text: text, alignment: .left)
    }
    
    public func setupViewController(_ title: String, text: String, alignment: NSTextAlignment) {
        self.title = title
        self.textView.text = text
        self.textView.textAlignment = alignment
    }
    
}
