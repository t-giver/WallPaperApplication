//
//  CollectionTopViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/06/28.
//

import UIKit

class CollectionTopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let sendData = SendData()
    var imgList: [NewImg] = [] // 画像リストを配列として保持する

    @IBOutlet weak var collectionImg: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNewList()
        collectionImg.delegate = self // delegateを設定する
        collectionImg.dataSource = self // dataSourceを設定する
    }
    
    func imgNewList(){
        sendData.fetchImg { result in
            DispatchQueue.main.async { // メインスレッドで更新する
                if let images = result {
                    self.imgList = images // 画像リストを保持する
                    self.collectionImg.reloadData() // コレクションビューを再読み込みする
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count // 画像リストの要素数を返す
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            let image = imgList[indexPath.item] // 表示する画像を取得する
            if let url = URL(string: image.urls.full) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.img.image = image
                        }
                    }
                }.resume()
            }
            cell.img.image = UIImage(named: image.urls.full) // 画像を表示する
            return cell
        }
        return UICollectionViewCell()
    }
}
