//
//  SearchResponse.swift
//  MainFeature
//
//  Created by 강치우 on 8/20/24.
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
