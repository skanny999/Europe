//
//  NetworkProvider.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {}

class NetworkProvider {
    
    private let urlSession: URLSessionProtocol
    
    init(with urlSession: URLSessionProtocol = URLSession.shared) {
        
        self.urlSession = urlSession
    }
    
    func getCountries(completion: @escaping (Result<Data, CountryError>) -> Void) {
        
        let task = self.urlSession.dataTask(with: Const.europeUrl) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkingError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200...299~=response.statusCode else {
                    completion(.failure(.networkingError))
                    return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
