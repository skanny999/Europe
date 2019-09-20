//
//  ServicesProtocols.swift
//  Europe
//
//  Created by Riccardo on 20/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Services

protocol DataProcessor {
    
    func processObjects<T: Updatable>(ofType: T.Type, with data: Data, completion: @escaping (Result<Bool, CountryError>) -> Void)
}


protocol StoredDataProvider {
    
    func allCountries() -> Result<[Country], CountryError>
}



// MARK: - Mocking

protocol CoreDataProvider {
    
    var mainContext: NSManagedObjectContext { get }
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}


protocol URLSessionProtocol {

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
