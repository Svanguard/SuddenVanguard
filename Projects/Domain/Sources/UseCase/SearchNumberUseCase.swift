//
//  SearchNumberUseCase.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol SearchNumberUseCase {
    func searchNumber(request: SearchNumberRequest) async throws -> SearchNumberResponse
}
