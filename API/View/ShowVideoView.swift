//
//  ShowVideoView.swift
//  API
//
//  Created by Daniil G on 11/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit
import AVKit
import WebKit

final class ShowVideoView: UIViewController {
    
    var videoURL = ""
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "https://www.youtube.com/embed/\(videoURL)")!)
        
        webView.load(request)
    }
}
