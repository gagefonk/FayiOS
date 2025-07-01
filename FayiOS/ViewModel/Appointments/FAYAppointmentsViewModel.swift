//  FAYAppointmentsViewModel.swift
//  FayiOS

import SwiftUI

class FAYAppointmentsViewModel: ObservableObject {
    
    // MARK: - PROPS
    let user: FayUser
    @Published var appointments: [FAYAppointment] = []
    @Published var isFetching: Bool = false
    
    // MARK: - INIT
    init(user: FayUser) {
        self.user = user
        fetchAppointments()
    }
    
    // MARK: - FUNCS
    
    func fetchAppointments() {
        isFetching = true
        Task {
            let service = FAYDataService(requestMethod: .get, endpoint: .appointments, token: user.token)
            let response = await service.initiateRequest()
            
            switch response {
            case .success(let (data, _)):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let appointmentData = try decoder.decode(FAYAppointmentResponse.self, from: data)
                    let appointmentsSorted = appointmentData.appointments.sorted(by: { $0.start < $1.start})
                    
                    Task { @MainActor in
                        self.appointments = []
                        self.appointments = appointmentsSorted
                    }
                } catch (let error) {
                    print(error.localizedDescription)
                }
                
            default:
                print("Error fetching appointments")
            }
            sleep(2)
            Task { @MainActor in
                isFetching = false
            }
        }
    }
    
    func getAppointmentDisplayMonth(for date: Date, component: FAYDateDisplayComponent, includeAMPM: Bool = false, includeTimeZone: Bool = false) -> String {
        let formatter = DateFormatter()
//        formatter.locale = .current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        
        switch component {
        case .month:
            formatter.dateFormat = "MMM"
        case .day:
            formatter.dateFormat = "d"
        case .time:
            var format = "hh:mm"
            if includeAMPM { format += " a"}
            if includeTimeZone { format += " (ZZZ)"}
            
            formatter.dateFormat = format
        }
        
        let dateComponent = formatter.string(from: date)
        
        return dateComponent
    }
    
    func getSekeltonData() -> [FAYAppointment] {
        var appointments: [FAYAppointment] = []
        appointments.append(FAYAppointment.sample!)
        appointments.append(FAYAppointment.sample!)
        appointments.append(FAYAppointment.sample!)
        appointments.append(FAYAppointment.sample!)
        return appointments
    }
}
