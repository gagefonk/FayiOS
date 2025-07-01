//
//  FayiOSApp.swift
//  FayiOS

import SwiftUI

@main
struct FayiOSApp: App {
    
    @State private var isAuthenticated: Bool = false
    @State private var user: FayUser?
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated, let user {
                FAYHomeView(user: user)
            } else {
                FAYLoginView(isAuthenticated: $isAuthenticated, user: $user)
            }
        } //windowgroup
    } //body
}
