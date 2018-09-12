//
//  Configuration.swift
//  Sky
//
//  Created by Rick on 2018/9/10.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation

struct API {
    static let key = "23af1fd63b894b9a6c7a09a245053cd4"
    

    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
        

}
