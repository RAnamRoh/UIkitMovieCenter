//
//  ApiClientImpl.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

class ApiClientImpl : ApiClient {
    func get<T>(url: URL) async throws -> T where T : Decodable {
        return try await request(url: url, method: "GET")
    }
    
    
    
    private func request<T: Decodable>(url : URL , method : String, body : Data? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = body
        }
        
       // logRequest(url: url, method: method, body: body)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
       // logResponse(data: data, response: response)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw ApiClientError.noData
        }
        
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        
        return decodedObject
        
        
    }
    
    
    private func logRequest(url: URL, method: String, body: Data?) {
        print("-----------------------------------LOG REQUEST------------------------------")
        print("Request URL: \(url)")
        print("HTTP Method: \(method)")
        if let body = body {
            if let jsonObject = try? JSONSerialization.jsonObject(with: body, options: []),
               let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let jsonString = String(data: prettyPrintedData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            } else if let jsonString = String(data: body, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            }
        }
    }
    
    private func logResponse(data: Data?, response: URLResponse?) {
        print("-----------------------------------LOG RESPONSE------------------------------")
        if let data = data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let jsonString = String(data: prettyPrintedData, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            } else if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
        }
    }
    
    
    
    
}
