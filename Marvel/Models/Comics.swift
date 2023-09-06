//
//  Comics.swift
//  Marvel
//
//  Created by Manny Alvarez on 06/09/2023.
//

import Foundation


struct APIComicsResult: Codable {
    var data: APIComicsData
}

struct APIComicsData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String:String]
    var urls: [[String:String]]
}
