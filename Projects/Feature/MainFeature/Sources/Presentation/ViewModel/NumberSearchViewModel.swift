//
//  NumberSearchViewModel.swift
//  MainFeature
//
//  Created by 최동호 on 9/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Core
import Common
import Domain
import Combine
import SwiftUI

final class NumberSearchViewModel: ObservableObject {
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    @Published var searchQuery = ""
    @Published var userData: SearchUserData = .init(suddenNumber: 0, userName: "", userImage: "")
    
    @Published var isSearchFieldFocused = true
    @Published var isLoading = false
    
    @Published var showResult = false
    @Published var resultType: PunishResultType = .clean
    @Published var userPunishDate = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let debounceDelay: TimeInterval = 0.7
    
    init() {
        setupSearchDebounce()
    }
    
    private func searchNumberToSudden() {
        guard let suddenNumber = Int(searchQuery), !searchQuery.isEmpty else {
            return
        }
        searchUseCase.searchNumberToSudden(suddenNumber: suddenNumber)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("서든병영 데이터 패치 에러: \(error)")
                }
            } receiveValue: { [weak self] userData in
                self?.isLoading = false
                self?.userData = userData
            }
            .store(in: &cancellables)
    }
    
    private func searchNumberToServer() {
        guard let suddenNumber = Int(searchQuery), !searchQuery.isEmpty else {
            return
        }
        searchUseCase.searchNumberToServer(suddenNumber: suddenNumber)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("서버 데이터 패치 에러: \(error)")
                }
            } receiveValue: { [weak self] (resultType, punishDate) in
                self?.resultType = resultType
                self?.userPunishDate = punishDate
            }
            .store(in: &cancellables)
    }
    
    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.isLoading = true
                
                self?.searchNumberToSudden()
                self?.searchNumberToServer()
            }
            .store(in: &cancellables)
    }
}

