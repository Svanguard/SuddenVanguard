//
//  MailContent.swift
//  ReportFeature
//
//  Created by 강치우 on 8/11/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct MailContent {
    var recipients: [String]
    var subject: String
    var body: String
    
    init(recipients: [String] = [], subject: String = "", body: String = "") {
        self.recipients = recipients
        self.subject = subject
        self.body = body
    }
    
    // MARK: 기본 메일 본문
    static func defaultMailContent() -> MailContent {
        let body = """
                핵 의심 유저 제보 내용

                - 닉네임 및 병영번호:
                - 스크린샷:
                - 날짜 및 시간:
                - 상세 설명:

                """
        
        return MailContent(
            recipients: ["suddenvanguard@gmail.com"],
            subject: "핵 의심 유저 제보",
            body: body
        )
    }
}
