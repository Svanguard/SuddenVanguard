//
//  MainViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Core
import Domain
import Combine
import SwiftUI

final class MainViewModel: ObservableObject {
    @Injected(SearchUseCase.self)
    public var useCase: SearchUseCase
    
    @Published var text: String = ""
    @Published var isEditing = false
    @Published var result: String = ""
    @Published var showSheet: Bool = false
    @Published var sheetType: SheetType = .clean

    private var cancellables = Set<AnyCancellable>()
    
    enum SheetType {
        case success
        case error
        case clean
    }

    private let mockData: [String: (SheetType, String)] = [
        "치우": (.error, "병영 번호로 검색하시겠어요?"),
        "김희성": (.success, "김희성(병영 번호)님은 전과가 있습니다."),
        "강치우": (.clean, "강치우(병영 번호)님은\n뱅가드에 등록되어 있지 않습니다.")
    ]
    
    func searchNickname() {
        guard !text.isEmpty else { return }
        
        if let data = mockData[text] {
            self.sheetType = data.0
            self.result = data.1
        } else {
            self.sheetType = .error
            self.result = "병영 번호로 검색하시겠어요?"
        }
        
        self.showSheet = true
    }
}
