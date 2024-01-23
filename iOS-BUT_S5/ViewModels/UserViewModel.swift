//
//  UserViewModel.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: [User])
        case failed(error: Error)
    }
    
    @Published var currentUser: User = User(id_user: 0, firstName: "", lastName: "", sex: "", company: "", biography: "", id: 0)
    
    @Published var state: State = .notAvailable
    
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
    }
    
    func getUserByStores(for id_store: Int) async {
        self.state = .loading
        do {
            let users = try await service.fetchStoreUsers(for: id_store)
            self.state = .success(data: users)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    func addUser(for body: User) async {
        self.state = .loading
        do {
            try await service.createUser(for: body)
            self.state = .success(data: [])
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    func updateUser(for body: User, id_user: Int) async {
        self.state = .loading
        do {
            let users = try await service.editUser(for: body, id_user: id_user)
            self.state = .success(data: users)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    func addUserToStore(for id_user: Int, id_store: Int) async {
        self.state = .loading
        do {
            try await service.addUserToStore(for: id_user, id_store: id_store)
            self.state = .success(data: [])
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    func removeUserFromStore(for id_user: Int) async {
        self.state = .loading
        do {
            try await service.removeUserFromStore(for: id_user)
            self.state = .success(data: [])
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
}
