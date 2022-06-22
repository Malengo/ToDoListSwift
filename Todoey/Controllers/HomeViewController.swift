//
//  HomeViewController.swift
//  Todoey
//
//  Created by user on 22/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

class HomeViewController: UINavigationController {
    
    var mainView: HomeView? {
        return view as? HomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let mainView = HomeView()
        mainView.setupView()
        mainView.setupConstraints()
        mainView.setupAdditionalConfiguration()
        view = mainView
    }
    
    @objc func realmAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "realmCategory")
        self.present(vc, animated: true)
    }
    
    @objc func coredataAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "coredataCategory")
        self.present(vc, animated: true)
    }
    
    func setupButtons() {
        mainView?.coreDataButton.addTarget(self, action: #selector(coredataAction), for: .touchDown)
        mainView?.realmDataButton.addTarget(self, action: #selector(realmAction), for: .touchDown)
    }

}
