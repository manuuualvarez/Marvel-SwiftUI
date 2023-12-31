//
//  Character.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import Foundation


struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String:String]
    var urls: [[String:String]]
}
