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
    
    override func loadView() {
           let configuration = WKWebViewConfiguration()
           webView = WKWebView(frame: .zero, configuration: configuration)
           view = webView
       }

    override func viewDidLoad() {
        super.viewDidLoad()
               let url = URL(string: "https://google.com")!
               let request = URLRequest(url: url)
               webView.load(request)
    }
    

}
