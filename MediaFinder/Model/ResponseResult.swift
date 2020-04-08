//
//  requestType.swift
//  MediaFinder
//
//  Created by Mina Helal on 3/30/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import Foundation

struct ResponseResult: Decodable{
    var resultCount: Int!
    var results: [Media?]
}
