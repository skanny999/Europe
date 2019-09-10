//
//  NetworkProvider.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}


class NetworkProvider {
    
    static let url = URL(string: "https://restcountries.eu/rest/v2/regionalbloc/eu")!
    
    static func getCountries(urlSession: URLSessionProtocol = URLSession.shared, completion: @escaping (Result<Data, CountryError>) -> Void) {
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.networkingError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkingError(nil)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200...299~=response.statusCode else {
                    completion(.failure(.networkingError(nil)))
                    return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
