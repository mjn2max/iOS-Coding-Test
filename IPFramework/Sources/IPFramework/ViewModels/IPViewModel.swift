//
// IPViewModel.swift
// FindMyIP
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI
import Combine

public class IPViewModel: ObservableObject {
    public enum PageState {
        case idle, loading, failed, success
    }
    
    @Published var pageState: PageState = .idle
    
    private(set) var ipData: IP?
    private var cancellable: Set<AnyCancellable> = []
    private var service: IPServiceProtocol?
    
    public init(pageState: PageState = .idle, service: IPServiceProtocol? = nil) {
        self.pageState = pageState
        self.service = service
    }
    
    
    public func fetchingData() {
        guard let service else {
            return
        }
        pageState = .loading
        service.getIPData()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finish")
                case .failure(_):
                    self.pageState = .failed
                }
            } receiveValue: { value in
                self.pageState = .success
                self.ipData = value
            }
            .store(in: &cancellable)
    }
}
