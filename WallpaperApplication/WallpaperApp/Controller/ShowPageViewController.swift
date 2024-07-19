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
        didTapImage(at: indent)
        
    }
    
    func didTapImage(at index: Int) {
        indent = index
        updateTitle()
    }

    func updateTitle() {
        if let jaSlug = selectImg[indent].alternative_slugs.ja {
            self.title = jaSlug.components(separatedBy: "-").first ?? jaSlug
              
        }
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
        
                        // リンク付きの author 表示
                        if let htmlString = selectImg[self.indent].links.html,
                           let url = URL(string: htmlString) {
                            let attributedString = NSMutableAttributedString(string: author)
                            attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: author.count))
                            self.authorLabel.attributedText = attributedString
                            self.authorLabel.isUserInteractionEnabled = true
                            self.authorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleLinkTap(_:))))
                        }
                        
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
    
    @objc func handleLinkTap(_ gesture: UITapGestureRecognizer) {
        // リンクがタップされた際の処理を実装
        if let url = self.authorLabel.attributedText?.attribute(.link, at: 0, effectiveRange: nil) as? URL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func tapImg() {
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
            expansionVC.tappedImageView = tappedImageView
        }
    }
}
