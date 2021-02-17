//
//  ShowDetailViewController.swift
//  TV Shows
//
//  Created by Ali Hassan on 10/02/2021.
//


import UIKit

class ShowDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: TVShowViewModel?
    
    private let showDetailInfoView: ShowDetailInfoView = {
        let infoView = ShowDetailInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false;
        infoView.isAccessibilityElement = false
        return infoView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        viewModel?.configureTVShowDetailView(showDetailInfoView)
    }
    
    // MARK: - Set Up
    
    private func setUpView(){
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.title = viewModel?.tvShowName
        
        self.view.addSubview(showDetailInfoView)
        NSLayoutConstraint.activate([
            showDetailInfoView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 16),
            showDetailInfoView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showDetailInfoView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            showDetailInfoView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
