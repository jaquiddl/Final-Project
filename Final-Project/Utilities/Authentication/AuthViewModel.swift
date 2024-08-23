//
//  AuthViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 18/07/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver = false
    
    @Published var userSession: FirebaseAuth.User? {
        didSet {
            print("DEBUG: userSession updated - \(String(describing: userSession))")
        }
    }
    @Published var currentUser: User? {
        didSet {
            print("DEBUG: currentUser updated - \(String(describing: currentUser))")
        }
    }
    @Published var isLoginSuccessful: Bool = true
    
    init() {
        self.userSession = Auth.auth().currentUser 
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.isWelcomeScreenOver = true
        } catch {
            self.isLoginSuccessful = false
            print(self.isLoginSuccessful)
            throw BookError.invalidData
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email, booksDictionary: [:], reviewed: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            self.isWelcomeScreenOver = true
        } catch {
            print("DEBUG: failed to create user")
            
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil// wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
        
        
    }
    func deleteAccount() {
        
    }
    func fetchUser () async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser  = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
}
