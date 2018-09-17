//
//  ViewController.swift
//  SampleProject
//
//  Created by Narasimha Rao Kundanapalli on 9/16/18.
//  Copyright © 2018 Narasimha Rao Kundanapalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let searchButton: UIButton = UIButton()
    fileprivate let textField: UITextField = UITextField()
    fileprivate let label: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View1"
        //self.view.backgroundColor = UIColor.red
        //Initialize the views
        initialize()
        addConstraints()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initialize() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name: "
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        self.view.addSubview(label)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Organization Name"
        textField.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
        self.view.addSubview(textField)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor.blue, for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .semibold)
        searchButton.addTarget(self, action: #selector(ViewController.onButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(searchButton)
    }
    
    fileprivate func addConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            label.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
            textField.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: label.topAnchor),
            textField.bottomAnchor.constraint(equalTo: label.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }

    @objc fileprivate func onButtonPressed(_ search: UIButton) {
        if  let text = textField.text, !text.isEmpty {
            let vc = CollectionViewController()
            vc.searchTerm = text
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            let alertController = UIAlertController(title: "", message: "Please enter the organization name", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                self.textField.becomeFirstResponder()
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

