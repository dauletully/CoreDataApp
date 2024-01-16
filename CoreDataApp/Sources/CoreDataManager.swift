//
//  CoreDataManager.swift
//  CoreDataApp

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    
    func saveData(currentName: String) {
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        guard let nameObject = NSEntityDescription.entity(forEntityName: "Person", in: context) else {return}
        
        let person = Person(entity: nameObject, insertInto: context)
        person.name = currentName

        do {
            try context.save()
            print("Data has been saved")

        } catch {
            print("Error has been occured during saving: \(error)")
        }
    }

    func fetchData() -> [Person] {
        var currentData = [Person]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {fatalError()}
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            currentData = try context.fetch(fetchRequest) as? [Person] ?? [Person()]
        } catch {
            print("Error occured during fetching data")
        }
        
        return currentData
    }

    func deleteData(userEntity: Person) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {fatalError()}
        context.delete(userEntity)
        
        do {
            try context.save()
            print("Data has been deleted")
        } catch {
            print("Error has been occured during deleting: \(error)")
        }
    }

}
