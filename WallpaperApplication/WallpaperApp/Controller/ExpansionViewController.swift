//
//  ExpansionViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/03.
//

import UIKit

class ExpansionViewController: UIViewController {
    @IBOutlet weak var tapimg: UIImageView!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    var tappedImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 5.0
        scroll.zoomScale = 1.0
        scroll.delegate = self
        if let tappedView = tappedImageView {
            self.tapimg.image = tappedView.image
        }
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        tapimg.addGestureRecognizer(doubleTapGesture)
    }
    @objc func doubleTap(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: tapimg)
        
        // タッチ位置が画像の範囲内かどうかをチェック
        if tapimg.bounds.contains(touchLocation) {
            if scroll.zoomScale > scroll.minimumZoomScale {
                scroll.setZoomScale(scroll.minimumZoomScale, animated: true)
            } else {
                let newScale = scroll.zoomScale * 2
                let scrollViewSize = CGSize(
                    width: tapimg.bounds.width / newScale,
                    height: tapimg.bounds.height / newScale
                )
                let origin = CGPoint(
                    x: touchLocation.x - (scrollViewSize.width / 2),
                    y: touchLocation.y - (scrollViewSize.height / 2)
                )
                let rect = CGRect(origin: origin, size: scrollViewSize)
                scroll.zoom(to: rect, animated: true)
            }
        }
    }
    
}

extension ExpansionViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return tapimg
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // ズームに合わせてビューの配置を調整する
        let imageViewSize = tapimg.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2.0 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    
}
