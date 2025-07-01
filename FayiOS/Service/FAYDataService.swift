//  FAYDataService.swift
//  FayiOS

import SwiftUI

enum FAYEndpoint {
    case signin, appointments
    
    var endpoint: String {
        switch self {
        case .signin:
            return "/signin"
        case .appointments:
            return "/appointments"
        }
    }
}

enum FAYRequestMethod {
    case get, post
    
    var methodString: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

class FAYDataService {
    
    private let rootURL: String = "https://node-api-for-candidates.onrender.com"
    var request: URLRequest
    
    init(requestMethod: FAYRequestMethod = .get, endpoint: FAYEndpoint, bodyData: Data? = nil, token: String? = nil) {
        let url = URL(string: "\(rootURL)\(endpoint.endpoint)")
        self.request = URLRequest(url: url!)
        self.request.httpMethod = requestMethod.methodString
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.timeoutInterval = 30
        
        if let bodyData = bodyData {
            self.request.httpBody = bodyData
        }
        
        if let token = token {
            self.request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    func initiateRequest() async -> Result<(Data, URLResponse), Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: self.request)
            return .success((data, response))
        } catch (let error) {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
}

struct FAYLoginResponse: Decodable {
    let token: String
}

struct FAYAppointmentResponse: Decodable {
    let appointments: [FAYAppointment]
}
