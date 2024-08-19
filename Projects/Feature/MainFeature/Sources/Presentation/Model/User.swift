//
//  User.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let rtnCode: Int
    let message: String?
    let result: SearchResults
}

struct SearchResults: Decodable {
    let characterInfo: [User]
    let total_cnt: Int
    let page_no: Int
}

struct User: Identifiable, Decodable, Encodable, Hashable {
    let user_nexon_sn: Int
    let user_nick: String
    let user_img: String
    
    var id: String { "\(user_nexon_sn)" }
}

