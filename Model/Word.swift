//
//  word.swift
//  wordSearch
//
//  Created by josefin hellgren on 2023-06-01.
//

import Foundation

struct Word : Codable, Identifiable{
    
    let word : String
    var id = UUID()
    
}
