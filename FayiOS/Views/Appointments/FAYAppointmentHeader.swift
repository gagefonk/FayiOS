//  FAYAppointmentHeader.swift
//  FayiOS

import SwiftUI

struct FAYAppointmentHeader: View {
    var body: some View {
        HStack {
            Text("Appointments")
                .font(.manrope(.bold, size: 24))
            
            Spacer()
            
            Button {
                return
            } label: {
                HStack {
                    Image("new_icon")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.brandNeutral)
                        .frame(width: 20, height: 20)
                    
                    Text("New")
                        .font(.manrope(.medium, size: 14))
                        .foregroundStyle(Color.brandNeutral)
                } //hstack
            } //button
            .frame(width: 90, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: .init(lineWidth: 1))
                    .foregroundStyle(Color.brandLight)
            )
            
        } //hstack
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    } //body
}

#Preview {
    FAYAppointmentHeader()
}
