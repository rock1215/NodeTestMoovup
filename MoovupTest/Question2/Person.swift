//
//  Person.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit
import Alamofire

class Person: NSObject {
    let id: String
    let first_name: String
    let last_name: String
    let email: String
    let picture: String
    let location: Location
    
    override init() {
        self.id = ""
        self.first_name = ""
        self.last_name = ""
        self.email = ""
        self.picture = ""
        self.location = Location(lat: 0, lng: 0)
    }
    
    init(_ data: [String: Any]) {
        if let id = data["_id"] as? String {
            self.id = id
        } else {
            self.id = ""
        }
        
        if let name = data["name"] as? [String: Any] {
            if let first_name = name["first"] as? String {
                self.first_name = first_name
            } else {
                self.first_name = ""
            }
            if let last_name = name["last"] as? String {
                self.last_name = last_name
            } else {
                self.last_name = ""
            }
        } else {
            self.first_name = ""
            self.last_name = ""
        }
        
        if let email = data["email"] as? String {
            self.email = email
        } else {
            self.email = ""
        }
        
        if let picture = data["picture"] as? String {
            self.picture = picture
        } else {
            self.picture = ""
        }
        
        if let locData = data["location"] as? [String: Any] {
            self.location = Location(locData)
        } else {
            self.location = Location(lat: 0, lng: 0)
        }
    }
    
    init(_ data: PersonData) {
        self.id = data.person_id
        self.first_name = data.first_name
        self.last_name = data.last_name
        self.email = data.email
        self.picture = data.picture
        self.location = Location(lat: data.lat, lng: data.lng)
    }
    
    class func getAllPersons(url: String, _ success: @escaping (_ results: [Person]) -> Void, _ failure: @escaping (_ error: Error?) -> Void) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: "v3srs6i1veetv3b2dolta9shrmttl72vnfzm220z")
        ]
        
        AF.request(url, headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                if let results = value as? [[String: Any]] {
                    var persons: [Person] = []
                    for result in results {
                        let person = Person(result)
                        PersonData.add(person: person)
                        persons.append(person)
                    }
                    
                    success(persons)
                } else {
                    failure(nil)
                }
                break
            case .failure(_):
                failure(nil)
                break
            }
        }
    }
}

class Location {
    let lat: Double
    let lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(_ data: [String: Any]) {
        if let lat = data["latitude"] as? Double {
            self.lat = lat
        } else {
            self.lat = 0
        }
        
        if let lng = data["longitude"] as? Double {
            self.lng = lng
        } else {
            self.lng = 0
        }
    }
}
