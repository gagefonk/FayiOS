//  FAYLoginView.swift
//  FayiOS

import SwiftUI

struct FAYLoginView: View {
    
    // MARK: - PROPS
    
    @Binding var isAuthenticated: Bool
    @Binding var user: FayUser?
    
    @StateObject private var viewModel: FAYLoginViewModel = FAYLoginViewModel()
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var isErrorShowing: Bool = false
    @State private var errorMessage: String = ""
    
    // MARK: - View
    var body: some View {
            VStack(spacing: 24) {
                HStack {
                    Text("Login")
                        .font(.manrope(.heavy, size: 50))
                        .foregroundStyle(Color.brandPrimary)
                    
                    Spacer()
                } //hstack
                
                TextField("User Name", text: $viewModel.userName)
                    .font(.manrope(size: 14))
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.brandLight)
                    .cornerRadius(10)
                
                HStack {
                    if showPassword {
                        TextField("Password", text: $viewModel.password)
                            .font(.manrope(size: 14))
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .font(.manrope(size: 14))
                    }
                    
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundStyle(Color.brandPrimary)
                    }
                } //hstack
                .padding()
                .background(Color.brandLight)
                .cornerRadius(10)
                
                FayButton(title: "Log In", action: {
                    isLoading = true
                    viewModel.loginPressed { result in
                        isLoading = false
                        switch result {
                        case .success(let authUser):
                            user = authUser
                            isAuthenticated = true
                            break
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                            isErrorShowing = true
                            break
                        }
                    }
                })
                
                Spacer()
                
            } //vstack
            .padding()
            .animation(.default, value: isErrorShowing)
            
            // MARK: - ALERTS
            .alert("Auth Error", isPresented: $isErrorShowing, actions: {
                Button("OK", role: .cancel) {
                    errorMessage = ""
                    isErrorShowing = false
                    viewModel.userName = ""
                    viewModel.password = ""
                }
            }, message: {
                Text(errorMessage)
            })
        }
}

#Preview {
    FAYLoginView(isAuthenticated: .constant(false), user: .constant(nil))
}
