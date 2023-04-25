//
//  WikipediaViewController.swift
//  Heroes App with Storyboard
//
//  Created by muhammad.alfarisi on 25/04/23.
//

import UIKit
import WebKit

class WikipediaViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: url ?? "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
}
