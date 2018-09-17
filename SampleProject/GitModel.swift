//
//  GitModel.swift
//  SampleProject
//
//  Created by Narasimha Rao Kundanapalli on 9/17/18.
//  Copyright © 2018 Narasimha Rao Kundanapalli. All rights reserved.
//

import Foundation

struct GitModel {
    let name: String?
    let desc: String?
    let createdDate: String?
    let license: [String:Any]?
    
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String
        self.desc = dictionary["description"] as? String
        self.createdDate = dictionary["created_at"] as? String
        self.license = dictionary["license"] as? [String:Any]
    }
}
