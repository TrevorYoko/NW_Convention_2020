//
//  UtilityWebViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/10/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit
import WebKit

class UtilityWebViewController:  UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView.init()
    var backButton: UIBarButtonItem?
    var nextButton: UIBarButtonItem?
    var stopButton: UIBarButtonItem?
    var refrestButton: UIBarButtonItem?
    var flexSpace: UIBarButtonItem?
    var shareButton: UIBarButtonItem?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(withUrlString urlString: String) {
        self.init(nibName: nil, bundle: nil)
        
        self.webView.load(URLRequest.init(url: URL.init(string: urlString)!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton = UIBarButtonItem.init(image: UIImage.init(named: "left-arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.backButton?.isEnabled = false
        
        self.nextButton = UIBarButtonItem.init(image: UIImage.init(named: "right-arrow"), style: .plain, target: self, action: #selector(nextButtonTapped))
        self.nextButton?.isEnabled = false
        
        self.stopButton = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped))
        
        self.refrestButton = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        self.shareButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        self.flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.setToolbarItems([self.backButton!, self.flexSpace!, self.nextButton!, self.flexSpace!, self.refrestButton!, self.flexSpace!, self.shareButton!], animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
    }
    
    // MARK - WKWebview Delegates
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.setupToolBar(forWebView: webView, shouldShowRefresh: false)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setupToolBar(forWebView: webView, shouldShowRefresh: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
        self.setupToolBar(forWebView: webView, shouldShowRefresh: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.setupToolBar(forWebView: webView, shouldShowRefresh: true)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.setupToolBar(forWebView: webView, shouldShowRefresh: true)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        self.setupToolBar(forWebView: webView, shouldShowRefresh: true)
    }
    
    // MARK - Private Functions
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        self.webView.goBack()
    }
    
    @objc private func nextButtonTapped() {
        self.webView.goForward()
    }
    
    @objc private func stopButtonTapped() {
        self.webView.stopLoading()
    }
    
    @objc private func refreshButtonTapped() {
        self.webView.reload()
    }
    
    @objc private func shareButtonTapped() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "Open in Safari", style: .default, handler: { (action) in
            if self.webView.url != nil {
                UIApplication.shared.open(self.webView.url!, options: [:], completionHandler: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Copy link", style: .default, handler: { (action) in
            if self.webView.url?.absoluteString != nil {
                let pasteBoard = UIPasteboard.general
                pasteBoard.string = self.webView.url?.absoluteString
            }
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupToolBar(forWebView wkWebView: WKWebView, shouldShowRefresh: Bool) {
        self.backButton?.isEnabled = webView.canGoBack
        self.nextButton?.isEnabled = webView.canGoForward
        self.refrestButton?.isEnabled = webView.url?.absoluteString != nil
        
        let optionalButton = shouldShowRefresh ? self.refrestButton : self.stopButton
        
        self.setToolbarItems([self.backButton!, self.flexSpace!, self.nextButton!, self.flexSpace!, optionalButton!, self.flexSpace!, self.shareButton!], animated: false)
    }
}
