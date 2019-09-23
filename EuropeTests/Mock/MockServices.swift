//
//  MockServices.swift
//  EuropeTests
//
//  Created by Riccardo on 23/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
@testable import Europe


class MockDataProcessor: DataProcessor {
    
    private let response: Result<Bool, CountryError>
    
    init(with response: Result<Bool, CountryError>) {
        self.response = response
    }
    
    func processObjects<T>(ofType: T.Type, with data: Data, completion: @escaping (Result<Bool, CountryError>) -> Void) where T : Updatable {
        
        completion(response)
    }
}


class MockStoreDataProvider: StoredDataProvider {
    
    private let response: Result<[Country], CountryError>
    
    init(with response: Result<[Country], CountryError>) {
        self.response = response
    }
    
    func allCountries() -> Result<[Country], CountryError> {
        
        return response
    }
}



public final class URLSessionMock : URLSessionProtocol {
    
    var url: URL?
    var request: URLRequest?
    private let dataTaskMock: URLSessionDataTaskMock
    
    public convenience init?(jsonDict: [String: AnyObject], response: URLResponse? = nil, error: Error? = nil) {
        guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
        self.init(data: data, response: response, error: error )
    }
    
    public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        dataTaskMock = URLSessionDataTaskMock()
        dataTaskMock.taskResponse = (data, response, error)
    }
    
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
    
    
    final private class URLSessionDataTaskMock : URLSessionDataTask {
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        var taskResponse: (Data?, URLResponse?, Error?)?
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
            }
        }
    }
}
