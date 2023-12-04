//
// IPMockService.swift
// FindMyIP
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI
import Combine
import Alamofire

public class MockFailedService: IPServiceProtocol {
    public func getIPData() -> AnyPublisher<IP, AFError> {
        return Fail(error: AFError.responseSerializationFailed(reason: .decodingFailed(error: NSError(domain: "Mock service failed", code: 404))))
            .eraseToAnyPublisher()
    }
}

public class MockSuccessService: IPServiceProtocol {
    public func getIPData() -> AnyPublisher<IP, AFError> {
        let json = """
{
    "ip": "181.214.196.60",
    "network": "181.214.196.0/24",
    "version": "IPv4",
    "city": "Dallas",
    "region": "Texas",
    "region_code": "TX",
    "country": "US",
    "country_name": "United States",
    "country_code": "US",
    "country_code_iso3": "USA",
    "country_capital": "Washington",
    "country_tld": ".us",
    "continent_code": "NA",
    "in_eu": false,
    "postal": "75225",
    "latitude": 32.8646,
    "longitude": -96.7884,
    "timezone": "America/Chicago",
    "utc_offset": "-0600",
    "country_calling_code": "+1",
    "currency": "USD",
    "currency_name": "Dollar",
    "languages": "en-US,es-US,haw,fr",
    "country_area": 9629091.0,
    "country_population": 327167434,
    "asn": "AS396356",
    "org": "LATITUDE-SH"
}
"""
        let jsonData = json.data(using: .utf8)!
        let ipData: IP = try! JSONDecoder().decode(IP.self, from: jsonData)
        return Just(ipData)
            .setFailureType(to: AFError.self)
            .eraseToAnyPublisher()
    }
}
