//
//  FooterTabView.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/01.
//

import UIKit

enum FooterTab{
    case home
    case tag
    case info
}

protocol FooterTabViewDelegate: AnyObject{
    func footerTabView(_ footerTabView: FooterTabView, didselectTab: FooterTab)
}

class FooterTabView: UIView {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!

    var delegate: FooterTabViewDelegate?

    
    @IBAction func didTapHome(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .home)
    }
    
    @IBAction func didTapTag(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .tag)
    }
    
    @IBAction func didTapInfo(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .info)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
        setup()
    }
    
    
    //影を背景につけて丸みをつけるコード
    func setup() {

//        // 角丸の設定
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
//        // 影の設定
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.cornerRadius = 20.0
        shadowView.layer.masksToBounds = false

        
    }


    
    
    
    func load(){
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView{
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
}
