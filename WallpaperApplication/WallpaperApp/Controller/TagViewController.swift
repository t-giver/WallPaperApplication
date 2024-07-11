//
//  TagViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/04.
//

import UIKit

class TagViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    let tagData = TagData()
    var tagList: [Result] = []
//    var redSelct = true
//    var blueSelect = false
//    var buttons: [UIButton] = []
    
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var tagImgs: UICollectionView!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagImgs.delegate = self
        tagImgs.dataSource = self
        imgTagList(tagColor: "red")
//        print(tagList)
        
//        tagImgs.register(Cell.self, forCellWithReuseIdentifier: "tagCell")

        
    }
    
    @IBAction func red(_ sender: Any) {
        imgTagList(tagColor: "red")
        self.tagImgs.reloadData()
      
    }
    
    @IBAction func blue(_ sender: Any) {
        imgTagList(tagColor: "blue")
        self.tagImgs.reloadData()
    }
    
    @IBAction func green(_ sender: Any) {
        imgTagList(tagColor: "green")
    }
    
    @IBAction func yellow(_ sender: Any) {
        imgTagList(tagColor: "yellow")
    }

    @IBAction func white(_ sender: Any) {
        imgTagList(tagColor: "white")
    }


    @IBAction func black(_ sender: Any) {
        imgTagList(tagColor: "black")
    }
    
    func imgTagList(tagColor color:String){
        tagData.fetchTagImg(tagColor:color){ result in
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
            let tagimage = tagList[indexPath.item]
            
            DispatchQueue.global().async {
                if let regular = tagimage.urls.regular, let url = URL(string: regular) {
                    if let data = try? Data(contentsOf: url), let cellImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.image.image = cellImage
                            print(cell)
                        }
                    }
                }
            }
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
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - 20) / 2 // セルの幅を少し小さくする
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // セルの間隔を少し空ける
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // セルの行間を少し空ける
    }
}
