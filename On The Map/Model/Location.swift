//
//  Location.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/18.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation

struct Location: Codable {
    let createdAt: String
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longtitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String
    let uniqueKey: String?
    let updatedAt: String 
    
    
    var locationLabel: String {
        var name = ""
        if let firstName = firstName {
            name = firstName
        }
        if let lastName = lastName {
            if name.isEmpty {
                name = lastName
            } else{
                name += " \(lastName)"
            }
        }
            if name.isEmpty {
                name = "FirstName Last Name"
            }
            return name
        }
    }
