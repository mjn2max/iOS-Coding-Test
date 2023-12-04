//
// IPService.swift
// FindMyIP
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI
import Alamofire
import Combine

public protocol IPServiceProtocol {
    func getIPData() -> AnyPublisher<IP, AFError>
}

public struct IPService: IPServiceProtocol {
    public init() {}
    
    public func getIPData() -> AnyPublisher<IP, Alamofire.AFError> {
        guard let url = URL(string: "https://ipapi.co/json/") else {
            let error = NSError(domain: "URL is NOT correct", code: 444)
            let afError = AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
            return Fail(error: afError).eraseToAnyPublisher()
        }
        
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: IP.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
