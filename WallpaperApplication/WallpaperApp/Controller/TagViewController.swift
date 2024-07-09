//
//  TagViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/04.
//

import UIKit

class TagViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    let tagData = SendData()
    var tagList: [NewImg] = []
    
    
    @IBOutlet weak var tagImgs: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagImgs.delegate = self
        tagImgs.dataSource = self
       imgTagList()
        
    }
    
    func imgTagList(){
        tagData.fetchImg { result in
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagCollectionViewCell {
            let images = tagList[indexPath.item]
            
            DispatchQueue.global().async {
                if let listimg = images.urls.regular, let url = URL(string: listimg) {
                    if let data = try? Data(contentsOf: url), let cellImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.image.image = cellImage
                        }
                    }
                }
            }
            print(images)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagShow",
           let showVC = segue.destination as? ShowPageViewController,
           let indexPath =  tagImgs.indexPathsForSelectedItems?.first {
            showVC.selectImg = tagList
            showVC.indent = indexPath.item
            
        }
    }
}


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
