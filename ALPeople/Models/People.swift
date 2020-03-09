//
//  People.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import Foundation

struct People {
    let gender: Gender
    let name: Name
    let picture: Picture
    let bob: Bob
    let email: String
    let cell: String
    let location: Location
    
    init() {
        name = Name()
        gender = .male
        picture = Picture()
        bob = Bob()
        email = ""
        cell = ""
        location = Location(coordinates: Coordinates())
    }
    
    init(json: [String: Any]) {
        name = Name(json: json["name"] as! [String: Any])
        email = json["email"] as! String
        cell = json["cell"] as! String
        gender = Gender(rawValue: json["gender"] as! String)!
        picture = Picture(json: json["picture"] as! [String: Any])
        bob = Bob(json: json["dob"] as! [String: Any])
        location = Location(json: json["location"] as! [String: Any])
    }
}

extension People: Equatable {
    
    public static func ==(lhs: People, rhs: People) -> Bool {
        if lhs.gender != rhs.gender {
            return false
        }
        if lhs.email != rhs.email {
            return false
        }
        if lhs.picture != rhs.picture {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        if lhs.cell != rhs.cell {
            return false
        }
        if lhs.bob != rhs.bob {
            return false
        }
        return true
    }
}

// MARK: - Name
struct Name: Codable, Equatable {
    let title, first, last: String
    
    init() {
        title = ""
        first = ""
        last = ""
    }
    
    init(json: [String: Any]) {
        title = json["title"] as! String
        first = json["first"] as! String
        last = json["last"] as! String
    }
    
    func fullName() -> String {
        "\(title) \(first) \(last)"
    }
    
    static func ==(lhs: Name, rhs: Name) -> Bool {
        if lhs.title != rhs.title {
            return false
        }
        if lhs.first != rhs.first {
            return false
        }
        if lhs.last != rhs.last {
            return false
        }
        return true
    }
}

// MARK: - Location
struct Location: Codable {
    let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    init(json: [String: Any]) {
        coordinates = Coordinates(json: json["coordinates"] as! [String: Any])
    }
    
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
    
    init() {
        latitude = ""
        longitude = ""
    }
    
    init(json: [String: Any]) {
        latitude = json["latitude"] as! String
        longitude = json["longitude"] as! String
    }
    
    static func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
        if lhs.latitude != rhs.latitude {
            return false
        }
        if lhs.longitude != rhs.longitude {
            return false
        }
        return true
    }
}

// MARK: - Picture
struct Picture: Codable, Equatable {
    let large, medium, thumbnail: String
    
    init() {
        large = ""
        medium = ""
        thumbnail = ""
    }
    
    init(json: [String: Any]) {
        large = json["large"] as! String
        medium = json["medium"] as! String
        thumbnail = json["thumbnail"] as! String
    }
    
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
        if lhs.large != rhs.large {
            return false
        }
        if lhs.medium != rhs.medium {
            return false
        }
        if lhs.thumbnail != rhs.thumbnail {
            return false
        }
        return true
    }
}

struct Bob: Codable, Equatable {
    let age: Int
    let date: Date
    
    init() {
        age = 0
        date = Date()
    }
    
    init(json: [String: Any]) {
        age = json["age"] as! Int
        let string = json["date"] as! String
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        self.date = RFC3339DateFormatter.date(from: string)!
    }
    
    static func ==(lhs: Bob, rhs: Bob) -> Bool {
        if lhs.age != rhs.age {
            return false
        }
        if lhs.date != rhs.date {
            return false
        }
        return true
    }
}

enum Gender: String {
    case male = "male"
    case female = "female"
}
