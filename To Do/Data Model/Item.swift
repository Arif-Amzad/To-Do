//
//  Item.swift
//  To Do
//
//  Created by Arif Amzad on 29/10/19.
//  Copyright © 2019 Arif Amzad. All rights reserved.
//

import Foundation

class Item: Codable {
    
    //Codable works for both Encodable and Decodable
    
    var title: String = ""
    var done: Bool = false
}
