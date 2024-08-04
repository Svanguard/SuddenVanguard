//
//  ReportModel.swift
//  ReportFeature
//
//  Created by 강치우 on 8/4/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ReportModel: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
}

extension ReportModel {
    static var items: [ReportModel] {
        [ReportModel(title: "핵 의심 유저를 어떻게 제보하나요?", subtitle: "오른쪽 상단의 제보 버튼을 눌러 메일을 보내주세요."),
         ReportModel(title: "제보할 때 어떤 정보를 제공해야 하나요?", subtitle: """
                                                                                                    다음 정보를 제공해 주시면 감사합니다:
                                                                                                    
                                                                                                    1. 핵 의심 장면의 스크린샷
                                                                                                    2. 핵 의심 유저의 닉네임 또는 병영 번호
                                                                                                    """),
         ReportModel(title: "제보한 내용은 어떻게 처리되나요?", subtitle: "제보된 내용은 저희 팀이 검토하여 핵 사용 여부를 판단합니다."),
         ReportModel(title: "제보 결과를 확인할 수 있나요?", subtitle: "제보 결과는 개인정보 보호를 위해 공개되지 않습니다. 제보된 유저가 핵 사용자로 판명될 경우 적절한 조치가 취해집니다."),
         ReportModel(title: "제보가 잘못된 경우는 어떻게 하나요?", subtitle: "잘못된 제보는 저희 팀이 검토 과정에서 확인하여 처리합니다. 고의적인 허위 제보는 제재를 받을 수 있으니, 신중하게 제보해 주세요."),
         ReportModel(title: "제보 후 몇 시간이 지나도 처리되지 않았어요.", subtitle: "신고된 내용은 접수 순서에 따라 처리되며, 처리 시간은 상황에 따라 달라질 수 있습니다. 조금만 더 기다려 주세요. 신고가 많을 경우 시간이 더 걸릴 수 있습니다."),
         ReportModel(title: "핵 사용이 의심되는 유저를 제보할 때 보상이 있나요?", subtitle: "현재 핵 사용 의심 유저를 제보하는 것에 대한 보상 프로그램은 운영하고 있지 않습니다. 그러나 여러분의 제보는 공정한 게임 환경을 유지하는 데 큰 도움이 됩니다.")
        ]
    }
}

struct exampleImage: Identifiable {
    let id = UUID()
    let imageName: UIImage
}

extension exampleImage {
    static var item: [exampleImage] {
        [ exampleImage(imageName: DesignSystemAsset.reportpic4.image),
          exampleImage(imageName: DesignSystemAsset.reportpic2.image),
          exampleImage(imageName: DesignSystemAsset.reportpic3.image),
          exampleImage(imageName: DesignSystemAsset.reportpic5.image)
        ]
    }
}
