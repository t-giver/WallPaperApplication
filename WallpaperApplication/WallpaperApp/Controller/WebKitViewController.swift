//
//  WebKitViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/05.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    
    var webView: WKWebView!
    @IBOutlet weak var webKit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
    }
    
    func loadWebPage(with url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

