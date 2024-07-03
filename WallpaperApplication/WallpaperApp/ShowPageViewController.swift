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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let img = selectImg.first, let url = img.urls.regular, let author = img.user.name, let source = img.links.download, let upDate = img.updated_at else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.showImg.image = image
                    self.authorLabel.text = author
                    
                    // 1. upDateLabel への表示
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale(identifier: "ja_JP")
                    dateFormatter.calendar = Calendar(identifier: .gregorian)
                    if let date = dateFormatter.date(from: upDate) {
                        dateFormatter.dateFormat = "yyyy年M月d日"
                        self.upDateLabel.text = dateFormatter.string(from: date)
                    }
                    if let url = URL(string: source), let host = url.host {
                        let displayName = host.components(separatedBy: ".").first ?? host
                        self.sourceLabel.text = displayName
                    }
                }
            }
        }
    }
}
