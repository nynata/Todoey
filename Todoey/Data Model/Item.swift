//
//  Item.swift
//  Todoey
//
//  Created by Nataly Zeldin on 3/27/19.
//  Copyright © 2019 Nataly Zeldin. All rights reserved.
//

import Foundation


class Item: Codable {
    
    var title : String = ""
    var done : Bool = false
}


// Make the item class conform to encodable: this enables it to be encodded into a json & decodable: can be decoded from another representation.... by making it conform to the Codable protocol
// For a class to be encodable, all of its properties must have standard data types
