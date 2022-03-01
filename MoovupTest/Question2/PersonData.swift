//
//  PersonData.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import Foundation
import RealmSwift

class PersonData: Object {
    @objc dynamic var id = -1
    @objc dynamic var person_id = ""
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var email = ""
    @objc dynamic var picture = ""
    @objc dynamic var lat: Double = 0
    @objc dynamic var lng: Double = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func IncrementaID() -> Int{
        let realm = PersonData.shared()
        if let retNext = realm.objects(PersonData.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func add(person: Person) {
        let data = PersonData()
        data.id = data.IncrementaID()
        data.person_id = person.id
        data.first_name = person.first_name
        data.last_name = person.last_name
        data.email = person.email
        data.picture = person.picture
        data.lat = person.location.lat
        data.lng = person.location.lng
        
        let realm = PersonData.shared()
        let result = realm.objects(PersonData.self).filter("person_id = %@", person.id)
        if result.count == 0 {
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    class func get() -> [Person] {
        var persons: [Person] = []
        
        let realm = PersonData.shared()
        let personDatas = realm.objects(PersonData.self)
        
        if personDatas.count > 0 {
            for data in personDatas {
                persons.append(Person(data))
            }
        }
        
        return persons
    }
    
    static func shared() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch _ as NSError {
            // uncomment and handle new properties here
            let configuration = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { _, _ in
                })
            
            Realm.Configuration.defaultConfiguration = configuration
            return try! Realm()
        }
    }
    
    
}
