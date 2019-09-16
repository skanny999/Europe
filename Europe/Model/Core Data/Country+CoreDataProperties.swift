//
//  Country+CoreDataProperties.swift
//  Europe
//
//  Created by Riccardo Scanavacca on 16/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var capital: String?
    @NSManaged public var flagData: NSData?
    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var population: Int64

}
