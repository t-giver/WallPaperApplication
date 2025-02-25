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
        collectionImg.delegate = self
        collectionImg.dataSource = self
        imgNewList()
        collectionImg.register(
            UINib(nibName: "SectionHeader", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader")
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
    
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 30) / 2, height: (view.bounds.width - 30) / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count // 画像リストの要素数を返す
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            let image = imgList[indexPath.item]
            DispatchQueue.global().async {
                if let regular = image.urls.regular, let url = URL(string: regular) {
                    if let data = try? Data(contentsOf: url), let cellImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.img.image = cellImage
                        }
                    }
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1. ヘッダーセクションを作成
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderMain", for: indexPath) as? SectionHeader else {
            fatalError("ヘッダーがありません")
        }
        
        // 2. ヘッダーセクションのラベルにテキストをセット
        if kind == UICollectionView.elementKindSectionHeader {
            header.titleLabel.text = "新着写真"
            return header
        }
        
        return UICollectionReusableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "topShow",
           let showVC = segue.destination as? ShowPageViewController,
           let indexPath =  collectionImg.indexPathsForSelectedItems?.first {
            showVC.selectImg = imgList
            showVC.indent = indexPath.item
            
        }
        
        
    }
}

extension CollectionTopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth: CGFloat
        let itemHeight: CGFloat
        
        let sectionInset: CGFloat = 10 // コレクションビューの左右の余白
        
        let itemSpacing: CGFloat = 10 // アイテム間の水平方向の余白
        let columnCount: CGFloat = 2 // 列数
        
        if indexPath.item == 0 {
            itemWidth = collectionViewWidth - (sectionInset * 2)
            itemHeight = itemWidth
        } else {
            itemWidth = (collectionViewWidth - (sectionInset * 2) - (itemSpacing * (columnCount - 1))) / columnCount
            itemHeight = itemWidth
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
