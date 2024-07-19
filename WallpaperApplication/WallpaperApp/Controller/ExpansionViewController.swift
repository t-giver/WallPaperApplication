//
//  ExpansionViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/03.
//

import UIKit

class ExpansionViewController: UIViewController {
    @IBOutlet weak var tapimg: UIImageView!

   
    var tappedImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let tappedView = tappedImageView {
            self.tapimg.image = tappedView.image
        }
    }
}
