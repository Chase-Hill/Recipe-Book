//
//  User.swift
//  Recipe Book
//
//  Created by Chase on 4/13/23.
//

import Foundation

class User {
    
    enum Key {
        static let uuid = "uuid"
    }
    
    var uuid: String
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.uuid: self.uuid
        ]
    }
    
    init(uuid: String) {
        self.uuid = uuid
    }
}

extension User {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let uuid = dictionary[Key.uuid] as? String else { return nil }
        
        self.init(uuid: uuid)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
