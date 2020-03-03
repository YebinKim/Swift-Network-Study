//
//  Multitag.swift
//  KapiVision
//
//  Created by Yebin Kim on 2020/03/03.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation

struct Multitag: Codable {
    
    // MARK: - Properties
    
    let result: Result
    
    // MARK: - Nested JSON Properties
    
    struct Result: Codable {
        
        let label: [String]
        let labelKR: [String]
        
        // MARK: - Codable Coding Key
        
        enum CodingKeys: String, CodingKey {
            case label
            case labelKR = "label_kr"
        }
        
    }
    
}
