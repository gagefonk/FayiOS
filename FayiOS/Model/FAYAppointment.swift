//  FAYAppointment.swift
//  FayiOS

import Foundation

enum FAYDateDisplayComponent {
    case month, day, time
}

struct FAYAppointment: Codable {
    let appointment_id: String
    let patient_id: String
    let provider_id: String
    let status: String
    let appointment_type: String
    let start: Date
    let end: Date
    let duration_in_minutes: Int
    let recurrence_type: String

    static let sample: FAYAppointment? = {
        let json = """
        {
            "appointment_id": "509teq10vh",
            "patient_id": "1",
            "provider_id": "100",
            "status": "Scheduled",
            "appointment_type": "Follow-up",
            "start": "2024-08-10T17:45:00Z",
            "end": "2024-08-10T18:30:00Z",
            "duration_in_minutes": 45,
            "recurrence_type": "Weekly"
        }
        """

        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            return try decoder.decode(FAYAppointment.self, from: data)
        } catch (let error) {
            print(error)
            return nil
        }
    }()
}
