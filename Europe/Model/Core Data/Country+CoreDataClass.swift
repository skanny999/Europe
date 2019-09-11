//
//  Country+CoreDataClass.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
import SVGKit

@objc(Country)
public class Country: NSManagedObject, Updatable {
    
    static var dataIdentifier: String = Const.countryDataIdentifier
    static var objectIdentifier: String = Const.countryObjectIdentifier
    
    func update(with dictionary: [String : Any]) {
        
        self.name = dictionary["name"] as? String
        self.capital = dictionary["capital"] as? String
        self.identifier = dictionary[Country.dataIdentifier] as? String
        self.population = dictionary["population"] as? Int64 ?? 0
        self.flagData = flagData(from: dictionary)
    }
    
    private func flagData(from dict: [String : Any]) -> NSData? {
        
        guard let imageUrlString = dict["flag"] as? String,
            let imageUrl = URL(string: imageUrlString),
            let urlData = try? Data(contentsOf: imageUrl),
            let uiimage = SVGKImage(data: urlData)?.uiImage,
            let data = uiimage.pngData() as NSData?
            else {
                return self.flagData
        }
        
        return data
    }
}
