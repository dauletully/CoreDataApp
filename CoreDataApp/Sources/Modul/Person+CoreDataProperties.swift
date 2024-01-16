//
//  Person+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 15.01.2024.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var birthday: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}

extension Person : Identifiable {

}
