//
//  User.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct User: Identifiable, Decodable, Encodable, Hashable {
    let user_nexon_sn: Int
    let user_nick: String
    let user_img: String
    
    var id: String { "\(user_nexon_sn)" }
}
