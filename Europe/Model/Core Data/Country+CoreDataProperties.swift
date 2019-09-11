//
//  Country+CoreDataProperties.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @NSManaged public var capital: String?
    @NSManaged public var flagData: NSData?
    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var population: Int64

}
