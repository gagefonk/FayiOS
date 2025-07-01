//  FAYAppointmentCardView.swift
//  FayiOS

import SwiftUI

struct FAYAppointmentCardView: View {
    
    @EnvironmentObject private var viewModel: FAYAppointmentsViewModel
    
    private let appointment: FAYAppointment
    private let buttonText: String?
    private let buttonIconName: String?
    private let buttonAction: (() -> Void)?
    private let isNextAppointment: Bool
    private var isPastAppointment: Bool { appointment.start < Date() }
    
    init(appointment: FAYAppointment, isNextAppointment: Bool = false, buttonText: String? = nil, buttonIconName: String? = nil, buttonAction: (()->Void)? = nil) {
        self.appointment = appointment
        self.isNextAppointment = isNextAppointment
        self.buttonText = buttonText
        self.buttonIconName = buttonIconName
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                
                let startTime = viewModel.getAppointmentDisplayMonth(for: appointment.start, component: .time, includeAMPM: isPastAppointment ? true : false, includeTimeZone: false)
                let endTime = viewModel.getAppointmentDisplayMonth(for: appointment.end, component: .time, includeAMPM: true, includeTimeZone: false)
                let month = viewModel.getAppointmentDisplayMonth(for: appointment.start, component: .month).capitalized
                let day = viewModel.getAppointmentDisplayMonth(for: appointment.start, component: .day)
                
                FAYCalendarView(month: month, day: day, pastAppointment: isPastAppointment)
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 10) {
                    if isPastAppointment {
                        Text(startTime)
                            .font(.manrope(.bold, size: 14))
                    } else {
                        Text(startTime + " - " + endTime)
                            .font(.manrope(.bold, size: 14))
                    }
                    
                    Text(appointment.status + (isNextAppointment && !isPastAppointment ? " with Jane Williams, RD": ""))
                        .font(.manrope(.medium, size: 12))
                        .foregroundStyle(Color.brandSubtle)
                }

                Spacer()
            } //hstack
            .padding()
            
            if buttonText != nil || buttonIconName != nil {
                FayButton(title: buttonText ?? "", titleSize: 14, titleWeight: .bold, imageName: buttonIconName ?? nil)
                    .frame(height: 44)
                    .padding()
            }
        } //vstack
        .frame(maxWidth: .infinity)
        .background(
            Group {
                if isNextAppointment {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brandLight, lineWidth: 1)
                        )
                }
            }
        ) //background

    } //body
}

fileprivate struct FAYCalendarView: View {
    
    let month: String
    let day: String
    let pastAppointment: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(month)
                .font(.manrope(.semibold, size: 14))
                .foregroundStyle(pastAppointment ? Color.brandTextBase : Color.brandPrimary)
                .frame(width: 48)
                .background(
                    Rectangle()
                        .fill(pastAppointment ? Color.brandCalendarPastBackground : Color.brandPrimary.opacity(0.2))
                )
            
            Text(day)
                .font(.manrope(.semibold, size: 18))
                .frame(width: 48, height: 27)
                .background(
                    Rectangle()
                        .fill(pastAppointment ? Color.brandCalendarPastBackground : Color.brandCalendarBackground)
                )
        }
    }
}

#Preview {
    if let appointment = FAYAppointment.sample {
        let user = FayUser.init(userName: "john")
        FAYAppointmentCardView(appointment: appointment, isNextAppointment: true, buttonText: "Join Appointment", buttonIconName: "Videocamera")
            .environmentObject(FAYAppointmentsViewModel(user: user))
    }
}
