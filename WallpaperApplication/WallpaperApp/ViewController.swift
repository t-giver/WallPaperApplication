//
//  ViewController.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/06/28.
//

import UIKit

class ViewController: UIViewController, FooterTabViewDelegate {
 
    

    @IBOutlet weak var footerTabView: FooterTabView!
    {
        didSet{
            footerTabView.delegate = self
        }
    }
    
    var selectedTab: FooterTab = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchViewController(selectedTab: .home)
    }
    
    func footerTabView(_ footerTabView: FooterTabView, didselectTab: FooterTab) {
        
    }
    
    private lazy var homeViewController: CollectionTopViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CollectionTopViewController") as! CollectionTopViewController
        add(childViewController: viewController)
        return viewController
    }()


    
    private func switchViewController(selectedTab:FooterTab) {
        switch selectedTab {
        case.home:
            add(childViewController: homeViewController)
        }
        self.selectedTab = selectedTab
        view.bringSubviewToFront(footerTabView)
    }
    
    private func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    private func remove(childViewController: UIViewController){
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }


}

