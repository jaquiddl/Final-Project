//
//  Alerts.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 03/08/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct alertContext {
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                              message: Text("The data received from the server was imvalid. Please contact support."),
                                              dismissButton: .default(Text("OK")))

    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from the server. Please try later or contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                              message: Text("There was an issue coneccting to the server. If the problem persists, please contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                              message: Text("Unable to complete your request. Please check your internet connection."),
                                              dismissButton: .default(Text("OK")))
    
    // Account Alerts
    
    static let invalidForm = AlertItem(title: Text("Empty Field"),
                                              message: Text("Must fill all fields."),
                                              dismissButton: .default(Text("OK")))
    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                              message: Text("Email email"),
                                              dismissButton: .default(Text("OK")))
    
    static let userSaveSuccess = AlertItem(title: Text("Profile Saved"),
                                              message: Text("Your profile information was successfully saved."),
                                              dismissButton: .default(Text("OK")))
    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                              message: Text("There was an error saving or retrieving your profile."),
                                              dismissButton: .default(Text("OK")))
    
    // Generic Error
    
    static let genericError = AlertItem(title: Text("Generic Error"),
                                              message: Text("Something went wrong."),
                                              dismissButton: .default(Text("OK")))
}
