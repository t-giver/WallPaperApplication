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
    var buttons: [UIButton] = []
    var selectedButton: UIButton?
    
    
    @IBOutlet weak var tagImgs: UICollectionView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagImgs.delegate = self
        tagImgs.dataSource = self
        imgTagList(tagColor: "red")
        tagImgs.collectionViewLayout = flowLayout
        
        buttons = [redButton, blueButton, whiteButton, yellowButton, greenButton, blackButton]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        updateButtonAppearance(for: buttons, isSelected: redButton)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // 前回選択されていたボタンの外観を戻す
        if let previousButton = selectedButton {
            previousButton.tintColor = .black
            previousButton.backgroundColor = .white
        }
        
        // 新しく選択されたボタンの外観を変更
        selectedButton = sender
        sender.tintColor = .white
        sender.backgroundColor = .black
    }
    
    func updateButtonAppearance(for buttons: [UIButton], isSelected: UIButton?) {
        for button in buttons {
            let color = button == isSelected ? UIColor.black : UIColor.white
            let tintColor = button == isSelected ? UIColor.white : UIColor.black
            
            button.backgroundColor = color
            button.tintColor = tintColor
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.0
            button.layer.cornerRadius = 5
        }
    }
    
    
    
    @IBAction func red(_ sender: Any) {
        imgTagList(tagColor: "red")
        updateButtonAppearance(for: buttons, isSelected: redButton)
    }
    
    @IBAction func blue(_ sender: Any) {
        imgTagList(tagColor: "blue")
        updateButtonAppearance(for: buttons, isSelected: blueButton)
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
            if let images = result {
                self.tagList = images
                DispatchQueue.main.async {
                    self.tagImgs.reloadData()
                    self.tagImgs.collectionViewLayout.invalidateLayout()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
        
    }
    
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 30) / 2, height: (view.bounds.width - 30) / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let tagimage = tagList[indexPath.item]
        
        DispatchQueue.global().async {
            if let regular = tagimage.urls.regular, let url = URL(string: regular) {
                URLSession.shared.dataTask(with: url) { (data, _, error) in
                    if let data = data, let cellImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.image.image = cellImage
                        }
                    }
                }.resume()
            }
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "tagShow",
//               let showVC = segue.destination as? ShowPageViewController,
//               let indexPath =  tagImgs.indexPathsForSelectedItems?.first {
//                let newImgList = tagList.map { NewImg(result: $0) }
//                      showVC.selectImg = newImgList
//                      showVC.indent = indexPath.item
//                  }
//
//            }
   }
    


extension TagViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        if indexPath.item == 0 {
            // 1つ目のセルは画面いっぱいの正方形
            return CGSize(width: collectionViewWidth, height: collectionViewWidth)
        } else {
            // 2つ目以降のセルは画面の半分の正方形
            let itemWidth = (collectionViewWidth - 30) / 2
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
}



