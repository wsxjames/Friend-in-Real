//
//  Business.swift
//  Friend in Real
//
//  Created by 吴世欣 on 3/15/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import Foundation

//struct RawServerResponse: Decodable{
//    let phone:String
////    let location:Location
//    struct Coordinates: Decodable{
//        let latitude:Double
//        let longitude: Double
//    }
//
//    let coordinates: Coordinates
//}
//
//struct Business: Decodable {
//   let phone:String
//   let lat:Double
//    let long: Double
//
//    init(from decoder: Decoder) throws {
//        let rawResponse = try RawServerResponse(from: decoder)
//
//        // Now you can pick items that are important to your data model,
//        // conveniently decoded into a Swift structure
//        phone=rawResponse.phone
//        lat=rawResponse.coordinates.latitude
//        long=rawResponse.coordinates.longitude
//    }
//}

//struct RawServerResponse: Decodable{
//
//    struct Coordinates: Decodable{
//        let latitude:Double
//        let longitude: Double
//    }
//
//    struct Business: Decodable{
//        let name: String
//        let coordinates: Coordinates
//    }
//
//    let business: [Business]
//
//}

//struct FinalResponse: Decodable{
//    let name: String
//    let lat: Double
//    let long: Double
//
//     init(from decoder: Decoder) throws {
//        let rawResponse = try RawServerResponse(from: decoder)
//
//            // Now you can pick items that are important to your data model,
//            // conveniently decoded into a Swift structure
//        name=rawResponse.business
//        lat=rawResponse.coordinates.latitude
//        long=rawResponse.coordinates.longitude
//        }
//
//}

import Foundation
import UIKit

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct Business: Codable{
    let name: String
    let coordinates: Coordinates
    let image_url: URL
    
}

struct FinalResponse: Codable{
    let businesses: [Business]
}




