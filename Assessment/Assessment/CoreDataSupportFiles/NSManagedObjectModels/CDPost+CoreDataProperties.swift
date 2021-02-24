//
//  CDPost+CoreDataProperties.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//
//

import Foundation
import CoreData


extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost")
    }

    @NSManaged public var userID: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension CDPost : Identifiable {

}
