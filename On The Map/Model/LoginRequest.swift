//
//  loginRequest.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/26.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let udacity: Udacity
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
    
    struct Udacity: Codable {
        let username: String
        let password: String
    }
}
