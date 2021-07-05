//
//  NewAraivaLData.swift
//  Movie Info
//
//  Created by Mohammed Ibrahim on 3/7/21.
//

import Foundation

struct NewAraivaLData : Codable{
    let results : [Results]
}

struct Results : Codable{
    let imageurl : [String]
    let genre : [String]
    let imdbid : String
    let title : String
    let runtime : String
    let imdbrating : Float?
    let type : String
    let synopsis : String
    let language : [String]
    //let streamingAvailability : [StreamingAvailability]
}
//
//struct StreamingAvailability : Decodable{
//    let country : [Country]
//    let updatedAt : [UpdatedAt]
//}
//
//struct Country : Decodable{
//    let country : [Country]
//}
//
//struct UpdatedAt : Decodable{
//
//}


