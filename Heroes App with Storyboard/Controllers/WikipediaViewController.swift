//
//  WikipediaViewController.swift
//  Heroes App with Storyboard
//
//  Created by muhammad.alfarisi on 25/04/23.
//

import UIKit
import WebKit

class WikipediaViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    var url: String?
    
    override func loadView() {
        super.loadView()
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.navigationDelegate = self
          view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: url ?? "www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
