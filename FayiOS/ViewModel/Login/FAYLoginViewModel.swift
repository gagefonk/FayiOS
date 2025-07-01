//  FAYLoginViewModel.swift
//  FayiOS

import Foundation

class FAYLoginViewModel: ObservableObject {
    
    // MARK: - PROPS
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    // MARK: - INIT
    
    init() {
        
    }
    
    // MARK: - FUNCS
    func loginPressed(completion: @escaping (Result<FayUser, Error>) -> Void) {
        guard userName.isEmpty == false, password.isEmpty == false else {
            completion(.failure(UserFetchError.empty))
            return
        }
        
        Task {
            do {
                let body = try JSONSerialization.data(withJSONObject: ["username": userName, "password": password])
                let service = FAYDataService(requestMethod: .post, endpoint: .signin, bodyData: body)
                let response = await service.initiateRequest()
                
                switch response {
                case .success(let (data, response)):
                    guard let response = response as? HTTPURLResponse else {
                        completion(.failure(UserFetchError.networkError))
                        return;
                    }
                    
                    switch response.statusCode {
                    case 200...299:
                        let loginResponse = try JSONDecoder().decode(FAYLoginResponse.self, from: data)
                        let user = FayUser(userName: userName, token: loginResponse.token)
                        completion(.success(user))
                        return
                    case 400...499:
                        completion(.failure(UserFetchError.invalidCredentials))
                        return
                    default:
                        completion(.failure(UserFetchError.networkError))
                        return
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(UserFetchError.networkError))
                    return
                }
            } catch (let error) {
                print(error)
                completion(.failure(UserFetchError.networkError))
                return
            }
        }
        
    }
}
