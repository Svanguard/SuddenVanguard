//
//  HttpResponseStatus.swift
//  Data
//
//  Created by 최동호 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

enum HttpResponseStatus {
    static let ok = 200...299
    static let existedUser = 409
    static let clientError = 400...499
    static let serverError = 500...599
}
