//
//  HomeView.swift
//  Todoey
//
//  Created by user on 22/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        return view
    }()
    
    lazy var coreDataButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    lazy var realmDataButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(coreDataButton)
        stackView.addArrangedSubview(realmDataButton)
    }
    
    func setupConstraints() {
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        coreDataButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        coreDataButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        coreDataButton.translatesAutoresizingMaskIntoConstraints = false
        
        realmDataButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        realmDataButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        realmDataButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 100
        
        coreDataButton.setTitle("CoreData", for: .normal)
        coreDataButton.setTitleColor(.white, for: .normal)
        coreDataButton.layer.cornerRadius = 8
        coreDataButton.clipsToBounds = true
        coreDataButton.backgroundColor = .systemBlue
        
        realmDataButton.setTitle("Realm Data", for: .normal)
        realmDataButton.setTitleColor(.white, for: .normal)
        realmDataButton.layer.cornerRadius = 8
        realmDataButton.clipsToBounds = true
        realmDataButton.backgroundColor = .systemBlue
    }
    
    

}
