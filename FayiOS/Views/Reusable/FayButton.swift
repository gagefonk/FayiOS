//
//  FayButton.swift
//  FayiOS

import SwiftUI

struct FayButton: View {
    
    private let title: String
    private let titleSize: CGFloat
    private let titleWeight: Font.Weight
    private let imageName: String?
    private let action: (() -> Void)?
    
    init(title: String, titleSize: CGFloat = 17, titleWeight: Font.Weight = .regular, imageName: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.titleSize = titleSize
        self.titleWeight = titleWeight
        self.imageName = imageName
        self.action = action
    }

    var body: some View {
        Button {
            (action ?? {})()
        } label: {
            HStack(spacing: 0) {
                if let imageName = imageName {
                    Image(imageName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text(title)
                    .font(.manrope(titleWeight, size: titleSize))
                    .padding()
            }
        } //button
        .frame(maxWidth: .infinity)
        .background(Color.brandPrimary)
        .foregroundStyle(.white)
        .cornerRadius(10)
    } //body
}

#Preview {
    FayButton(title: "TEST BUTTON", imageName: "Videocamera")
}
