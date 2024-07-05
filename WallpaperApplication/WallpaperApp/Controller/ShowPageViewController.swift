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
        setupSelectedImage(selectImg: self.selectImg)
        tapImg()
        
        //        webView.view.translatesAutoresizingMaskIntoConstraints = false
        //               addChild(webView)
        //               view.addSubview(webView.view)
        //               webView.didMove(toParent: self)
        //
        
    }
    
    
    func setupSelectedImage(selectImg: [NewImg]){
        let selectedImg = selectImg[indent]
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
       
    }
    
    @objc func authorLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let urlString = selectImg[indent].links.html, let url = URL(string: urlString) else {
            return
        }
        
        let webViewVC = WebKitViewController()
        webViewVC.loadWebPage(with: url)
        
        // モーダルで表示する場合
        present(webViewVC, animated: true, completion: nil)
    }
    
    func tapImg(){
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
