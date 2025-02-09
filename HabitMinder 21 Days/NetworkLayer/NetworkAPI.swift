//
//  NetworkAPI.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/7/24.
//

import Foundation

final class NetworkAPI {
    func fetchData<T: Decodable>(from endpoint: Endpoint, decodeType: T.Type, success: @escaping SuccessClosure<T>, failure: @escaping FailureClosure) {
        let urlString = endpoint.baseURL + endpoint.path
        guard let url = URL(string: urlString) else {
            failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.header?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                failure(error)
                return
            }
            guard let data = data else {
                failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No Data"]))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                success(decodedResponse)
            } catch {
                failure(error)
            }
        }.resume()
    }
}
