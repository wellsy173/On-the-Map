//
//  UdacityClient.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/11.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var sessionId: String?
        static var key = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }
    
    enum Endpoints {
        
        static let base = "https://onthemap-api.udacity.com/v1"
         
        case udacitySignUp
        case login
        case addStudentLocation
        case gettingStudentLocations
        case updateStudentLocation
        case logout
        
        var stringValue: String {
            switch self {
            case .udacitySignUp:
                return "https://auth.udacity.com/sign-up"
            case .login:
                return Endpoints.base + "/session/"
            case .addStudentLocation:
                return Endpoints.base + "/StudentLocation/"
            case .gettingStudentLocations:
                return Endpoints.base + "/StudentLocation?limit=100"
            case .updateStudentLocation:
                return Endpoints.base + "/StudentLocation/8ZExGR5uX8/"
            case .logout:
                return Endpoints.base + "/session/"
            }
        }
        var url: URL {
        return URL(string: stringValue)!
    }
        
        
        
}
    
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, apiType: String, responseType:  ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   guard let data = data else {
                       DispatchQueue.main.async {
                           completion(nil, error)
                       }
                       return
    }
            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(SessionResponse.self, from: data) as! Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
                }
            }
        task.resume()
    }
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil, error)
            }
            return
        }
            let decoder = JSONDecoder()
            do {
                let responseObject = try
                    decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }catch{
                do {
                let errorReponse = try
                    decoder.decode(SessionResponse.self, from: data) as! Error
                DispatchQueue.main.async {
                    completion(nil, errorReponse)
                }
            }catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                }
                
            }
            }
    task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
         let body = LoginRequest(udacity: LoginRequest.Udacity(username: username, password: password))
        taskForPostRequest(url: Endpoints.login.url, responseType: LoginRequest.self, body: body) { response, error in
    }
        
}
    
    class func studentsLocation(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.gettingStudentLocations.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                completion (false, error)
                return
            }
            print (String(data: data!, encoding: .utf8)!)
        }
        task.resume()
}
    
    class func addStudentLocation(information: StudentInformation, completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.addStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                completion (false, error)
                return
            }
            print (String(data: data!, encoding: .utf8)!)
        }
        task.resume()
}
    
    class func updateStudentLocation(information: StudentInformation, completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.updateStudentLocation.url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion (false, error)
                return
            }
            print (String(data: data!, encoding: .utf8)!)
    }
        task.resume()
}
    
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.logout.url)
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
            completion (false, error) //print error logging out?
            return
    }
        let range = 5..<data!.count
            let newData = data?.subdata(in: range)
            print (String(data: newData!, encoding: .utf8)!)
            Auth.sessionId = ""
            completion(false, error)
        }
        
        task.resume()
            
        
}
}
