//
//  Logger.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import Foundation


enum LoggedTypes {
    case error
    case noData
    case success
}

func logged(type: LoggedTypes, message: String, fileName: String = "", method: String = "") {
    switch type {
    case .error:
        print("❌ Error: \(message), on: \(fileName), when: \(method) called.")
    case .noData:
        print("👎🏻 NoData: \(message), on: \(fileName), when: \(method) called.")
    case .success:
        print("✅ Success: \(message)")
    }
    
}
