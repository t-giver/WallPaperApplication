//
//  TagViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/04.
//

import UIKit

class TagViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    let tagData = TagData()
    var tagList: [TagImg] = []
    
    
    
    @IBOutlet weak var tagImgs: UICollectionView!
    
    @IBAction func red(_ sender: Any) {
        //        for (index, image) in tagList.enumerated() {
        //             if image.color == "red" {
        //                 let filteredImage = self.applyRedFilter(to: image)
        //                 tagList[index].image = filteredImage
        //             }
        //         }
        //
        //         // コレクションビューを再読み込みする
        //         collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagImgs.delegate = self
        tagImgs.dataSource = self
        imgTagList()
        
        
        
        
        
    }
    
    func imgTagList(){
        tagData.fetchTagImg { result in
            DispatchQueue.main.async { // メインスレッドで更新する
                if let images = result {
                    self.tagList = images // 画像リストを保持する
                    self.tagImgs.reloadData() // コレクションビューを再読み込みする
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
        
    }
    
    func applyRedFilter(to image: UIImage) -> UIImage {
        // 赤色のフィルターを適用する処理
        // ...
        return image
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagCollectionViewCell {
            let tagimage = tagList[indexPath.item]
            
            
            if let firstResult = tagimage.results.first, firstResult.color == "red"  {
                DispatchQueue.global().async {
                    if let imageURL = URL(string: firstResult.urls.regular ?? "https://via.placeholder.com/150"), let imageData = try? Data(contentsOf: imageURL), let cellImage = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            // 赤色のフィルターをかける処理
                            cell.image.image = self.applyRedFilter(to: cellImage)
                        }
                    }
                }
            } else {
                DispatchQueue.global().async {
                    
                    if let firstResult = tagimage.results.first, let imageURL = URL(string: firstResult.urls.regular ?? "https://via.placeholder.com/150"), let imageData = try? Data(contentsOf: imageURL), let cellImage = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            cell.image.image = cellImage
                        }
                    }
                }
            }
            print(tagimage)
            return cell
        }
        return UICollectionViewCell()
    }
}


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "tagShow",
//           let showVC = segue.destination as? ShowPageViewController,
//           let indexPath =  tagImgs.indexPathsForSelectedItems?.first {
//            showVC.selectImg = tagList
//            showVC.indent = indexPath.item
//            
//        }
//    }



extension TagViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let collectionViewWidth = collectionView.bounds.width
            let itemWidth = collectionViewWidth
            return CGSize(width: itemWidth, height: itemWidth)
        } else {
            let collectionViewWidth = collectionView.bounds.width
            let itemWidth = collectionViewWidth / 2
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
