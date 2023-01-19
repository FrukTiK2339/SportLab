//
//  MOUserInfo+CoreDataProperties.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//
//

import Foundation
import CoreData


extension MOUserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOUserInfo> {
        return NSFetchRequest<MOUserInfo>(entityName: "MOUserInfo")
    }

    @NSManaged public var currentWeight: Int32
    @NSManaged public var targetWeight: Int32
    @NSManaged public var name: String
    @NSManaged public var image: Data

}

extension MOUserInfo : Identifiable {

}
