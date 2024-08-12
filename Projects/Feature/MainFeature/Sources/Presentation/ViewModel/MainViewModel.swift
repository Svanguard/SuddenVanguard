//
//  MainViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isEditing = false
    @Published var result: String = ""
    @Published var showSheet: Bool = false
    @Published var sheetType: SheetType = .clean

    private var cancellables = Set<AnyCancellable>()
    
    private let mockData: [String: SearchResult] = [
        "치우": SearchResult(sheetType: .error, message: "병영 번호로 검색하시겠어요?"),
        "김희성": SearchResult(sheetType: .success, message: "김희성(병영 번호)님은 전과가 있습니다."),
        "강치우": SearchResult(sheetType: .clean, message: "강치우(병영 번호)님은\n뱅가드에 등록되어 있지 않습니다.")
    ]
    
    func searchNickname() {
        guard !text.isEmpty else { return }
        
        if let data = mockData[text] {
            self.sheetType = data.sheetType
            self.result = data.message
        } else {
            self.sheetType = .error
            self.result = "병영 번호로 검색하시겠어요?"
        }
        
        self.showSheet = true
    }
}
