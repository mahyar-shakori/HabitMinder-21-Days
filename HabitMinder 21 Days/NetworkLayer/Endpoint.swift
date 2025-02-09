//
//  Endpoint.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/6/24.
//

import Foundation

struct NinjasAPI {
    static let url: String = "api-ninjas.com"
}

protocol Endpoint {
    var baseURL:    String            { get }
    var path:       String            { get }
    var method:     HTTPMethod        { get }
    var body:       [String: Any]?    { get }
    var header:     [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        "https://api.\(NinjasAPI.url)"
    }
}
