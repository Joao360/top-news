//
//  WebViewController.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    var url: String!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let builtUrl = URL(string: url)!
        webView.load(URLRequest(url: builtUrl))
    }
}
