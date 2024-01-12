//
//  StoreViewModel.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

@MainActor
class StoreViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: [Store])
        case failed(error: Error)
    }
    
    @Published var state: State = .notAvailable
    
    private let service: StoreService
    
    init(service: StoreService) {
        self.service = service
    }
    
    func getStores() async {
        self.state = .loading
        do {
            let stores = try await service.fetchStore()
            self.state = .success(data: stores)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
}
