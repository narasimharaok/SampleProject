//
//  CollectionViewController.swift
//  SampleProject
//
//  Created by Narasimha Rao Kundanapalli on 9/16/18.
//  Copyright © 2018 Narasimha Rao Kundanapalli. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate var collectionView: UICollectionView!
    fileprivate let layout = UICollectionViewFlowLayout()
    fileprivate let segmentedControl = UISegmentedControl(items: ["List", "Grid"])
    fileprivate var items: [GitModel]? = []
    fileprivate var pageNum = 1
    fileprivate var perPage = 10
    var searchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CollectionView Controller"
        segmentedControl.addTarget(self, action: #selector(CollectionViewController.changeView), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentedControl
        view.backgroundColor = UIColor.gray
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: self.view.frame.width - 4, height: 300)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.gray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collection_cell")
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 2),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -2),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        Network.shared.getGitData(forCompany: searchTerm, pageNumber: pageNum, perPage: perPage) { models in
            self.items = models
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setItemSize(size)
        // we can improve the UI by using the compact and regular classes.
        // For ex: only for compcat use the list view and when we switch to regular chang the UI to regular
        /*if self.traitCollection.horizontalSizeClass == .compact {
            
        } else if self.traitCollection.horizontalSizeClass == .regular {
            
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Collection View delegage and data source methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as? CollectionViewCell else {
                abort()
        }
        if let items = self.items {
            if indexPath.row  ==  items.count - 1 {
                pageNum += 1
                //We can use prefecting also to get the data for faster use.
                Network.shared.getGitData(forCompany: searchTerm, pageNumber: pageNum, perPage: perPage) { models in
                    for model in models! {
                        self.items?.append(model)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
            let data = items[indexPath.row]
            cell.updateCell(data)
        }
        return cell
    }
    
    fileprivate func setItemSize(_ size: CGSize) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        if selectedIndex == 0 {
            layout.itemSize = CGSize(width: size.width - 4, height: 300)
            layout.invalidateLayout()
        } else {
            // trailing 2, leading 2 and padding 10
            layout.itemSize = CGSize(width: (size.width - 14) / 2, height: 300)
            layout.invalidateLayout()
        }
    }
    
    //Segmented contorl action
    @objc fileprivate func changeView() {
        setItemSize(self.view.frame.size)
    }
}
