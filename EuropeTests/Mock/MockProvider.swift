//
//  MockProvider.swift
//  EuropeTests
//
//  Created by Riccardo Scanavacca on 10/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData
@testable import Europe

class MockProvider {

    static let shared: MockProvider = MockProvider()
    
    var mockCountry: Country {
        return country!
    }
    
    init() {
        
        if country == nil {
            let context = inMemoryManagedObjectContext()
            self.context = context
            let country = Country(entity: NSEntityDescription.entity(forEntityName: "Country", in: context)!, insertInto: context)
            country.update(with: mockCountryJson)
            try! context.save()
            self.country = country
        }
    }
    
    private var country: Country?
    private var context: NSManagedObjectContext?
    
    var mockCountryJson: [String: Any] {
        
        let data = FileExtractor.extractJsonFile(withName: "Country", forClass: MockProvider.self)
        
        let jsonArray = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
        return jsonArray.first!
    }
    
    func inMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from:[Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
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
