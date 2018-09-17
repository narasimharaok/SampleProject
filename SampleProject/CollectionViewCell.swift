//
//  CollectionViewCell.swift
//  SampleProject
//
//  Created by Narasimha Rao Kundanapalli on 9/16/18.
//  Copyright © 2018 Narasimha Rao Kundanapalli. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var name = UILabel(frame: CGRect.zero)
    var desc = UILabel(frame: CGRect.zero)
    var createdDate = UILabel(frame: CGRect.zero)
    var license = UILabel(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = 5
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        name.numberOfLines = 3
        self.contentView.addSubview(name)
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        desc.numberOfLines = 3
        self.contentView.addSubview(desc)
        
        createdDate.translatesAutoresizingMaskIntoConstraints = false
        createdDate.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        createdDate.numberOfLines = 3
        self.contentView.addSubview(createdDate)
        
        license.translatesAutoresizingMaskIntoConstraints = false
        license.numberOfLines = 3
        license.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        self.contentView.addSubview(license)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["name": name])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["desc": desc])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[createdDate]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["createdDate": createdDate])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[license]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["license": license])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(5)-[name]-(<=5)-[desc]-(<=5)-[createdDate]-(<=5)-[license]-(>=5)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["name": name, "desc": desc, "createdDate": createdDate, "license": license])
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        self.name.text = ""
        self.desc.text = ""
        self.createdDate.text = ""
        self.license.text = ""
    }
    
    func updateCell(_ data: GitModel?) {
        guard let data = data else {
            return
        }
        if let name = data.name {
            self.name.text = "Name:\(name)"
        } else {
            self.name.text = ""
        }
        
        if let desc = data.desc {
            self.desc.text = "Description:\(desc)"
        } else {
            self.desc.text = ""
        }
        
        if let createdDate = data.createdDate {
            self.createdDate.text = "Date:\(createdDate)"
        } else {
            self.createdDate.text = ""
        }
        
        if let license = data.license {
            if let name = license["name"] {
                self.license.text = "License:\(name)"
            } else {
                self.license.text = ""
            }
        }
        
    }
}
