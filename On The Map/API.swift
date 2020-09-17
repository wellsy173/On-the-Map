//
//  API.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/6.
//  Copyright © 2020 Simon Wells. All rights reserved.
//
/*
import Foundation
import UIKit
import CoreLocation

class API {
    
    class func sharedInstance() -> API {
    struct Singleton {
        static var sharedInstance = API()
        }
        return Singleton.sharedInstance
    }

    class func login(username: String, password: String, completion: @escaping (Bool,Error?)
        -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                completion (false, error)
                return 
            }
        }
            task.resume()
    
    

}
    /*
    class func logout(completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap=api=udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion (false)
                return
    }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range) /*subset response data*/
            print (String(data: newData!, encoding: .utf8)!)
            
}
        task.resume()
        
}
*/
*/
