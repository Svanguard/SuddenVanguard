//
//  RankUseCase.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol RankUseCase {
    func getRankData() async throws -> RankResponse
}
