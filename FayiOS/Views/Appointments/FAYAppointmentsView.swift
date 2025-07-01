//  FAYAppointmentsView.swift
//  FayiOS

import SwiftUI

fileprivate enum Tabs: String, CaseIterable, Identifiable {
    case upcoming
    case past
    
    var id: String { rawValue }
    var title: String { String(rawValue).capitalized  }
}

struct FAYAppointmentsView: View {
    
    @State private var selectedTab: Tabs = .upcoming
    @StateObject private var viewModel: FAYAppointmentsViewModel
    
    let user: FayUser
    
    init(user: FayUser) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FAYAppointmentsViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            FAYAppointmentHeader()
            
            HStack(spacing: 0) {
                ForEach(Tabs.allCases) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        VStack {
                            Text(tab.title)
                                .font(.manrope(size: 14))
                                .foregroundStyle(selectedTab == tab ? Color.brandPrimary : Color.brandNeutral)
                            
                            Rectangle()
                                .fill(selectedTab == tab ? Color.brandPrimary : Color.brandLight)
                                .frame(height: 1)
                        } //vstack
                    } //button
                } //foreach
            } //hstack
            ScrollView {
                switch selectedTab {
                case .upcoming:
                    if viewModel.isFetching {
                        ForEach(viewModel.getSekeltonData(), id: \.appointment_id) { appointment in
                            FAYAppointmentCardView(appointment: appointment)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .redacted(reason: .placeholder)
                                .shimmer()
                        } //foreach
                    } else {
                        let filteredDates = viewModel.appointments.filter { $0.start > Date() }
                        ForEach(filteredDates, id: \.appointment_id) { appointment in
                            let isNextAppointment = appointment.appointment_id == filteredDates.first?.appointment_id
                            Group {
                                if isNextAppointment {
                                    FAYAppointmentCardView(appointment: appointment, isNextAppointment: isNextAppointment, buttonText: "Join appointment", buttonIconName: "Videocamera", buttonAction: nil)
                                } else {
                                    FAYAppointmentCardView(appointment: appointment)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        } //foreach
                    }
                case .past:
                    if viewModel.isFetching {
                        ForEach(viewModel.getSekeltonData(), id: \.appointment_id) { appointment in
                            FAYAppointmentCardView(appointment: appointment)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .redacted(reason: .placeholder)
                                .shimmer()
                        } //foreach
                    } else {
                        ForEach(viewModel.appointments.filter { $0.start < Date()}, id: \.appointment_id) { appointment in
                            FAYAppointmentCardView(appointment: appointment)
                        } //foreach
                    }
                } //switch
            } //scrollview
            
            Spacer()
        }
        .environmentObject(viewModel)
    } //body
}

#Preview {
    FAYAppointmentsView(user: FayUser(userName: "john"))
}
