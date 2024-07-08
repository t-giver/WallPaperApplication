//
//  ExpansionViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/03.
//

import UIKit

class ExpansionViewController: UIViewController {
    @IBOutlet weak var tapimg: UIImageView!
//    var tapImge: [NewImg] = []
   
    var tappedImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
       
//        // 1. tapImgeから最初の画像を取得
//        if let firstImg = tapImge.first, let regularSize = firstImg.urls.regular {
//            DispatchQueue.global().async {
//                if let url = URL(string: regularSize), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.tapimg.image = image
//                    }
//                }
//            }
//
//        }
        // 2. tappedImageViewがある場合は、それをtapimgにコピー
        if let tappedView = tappedImageView {
            self.tapimg.image = tappedView.image
        }
    }
}
