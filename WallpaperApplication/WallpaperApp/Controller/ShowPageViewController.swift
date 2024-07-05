//
//  ShowPageViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/02.
//

import UIKit

class ShowPageViewController: UIViewController {
    
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var upDateLabel: UILabel!
    var selectImg:[NewImg] = []
    var indent:Int = 0
    let webView = WebKitViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 選択された画像の情報を取得する
        let selectedImg = selectImg[indent]
        
        webView.view.translatesAutoresizingMaskIntoConstraints = false
               addChild(webView)
               view.addSubview(webView.view)
               webView.didMove(toParent: self)
     
            
        
        // 画像の表示処理
        DispatchQueue.global().async {
            if let regular = selectedImg.urls.regular,
               let author = selectedImg.user.name,
               let upDate = selectedImg.updated_at,
               let url = URL(string: regular) {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.showImg.image = image
                        self.authorLabel.text = author
                      
                        
                        // upDateLabel への表示
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        dateFormatter.locale = Locale(identifier: "ja_JP")
                        dateFormatter.calendar = Calendar(identifier: .gregorian)
                        if let date = dateFormatter.date(from: upDate) {
                            dateFormatter.dateFormat = "yyyy年M月d日"
                            self.upDateLabel.text = dateFormatter.string(from: date)
                        }
                        
                        if let locationData = selectedImg.user.location {
                            self.sourceLabel.text = locationData
                           
                        } else {
                            self.sourceLabel.text = nil
                        }
                    }
                }
            }
        }

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImageTapped(_:)))
        showImg.addGestureRecognizer(tapGesture)
        showImg.isUserInteractionEnabled = true
    }
    
    
    @objc func showImageTapped(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "expansion", sender: showImg)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expansion",
           let expansionVC = segue.destination as? ExpansionViewController,
           let tappedImageView = sender as? UIImageView {
            expansionVC.tapImge = selectImg
            expansionVC.tappedImageView = tappedImageView
        }
    }
}
