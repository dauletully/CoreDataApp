//
//  CoreDataManager.swift
//  CoreDataApp

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    //MARK: - Saving inputting data to storage
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

    //MARK: - Updating data in storage
    func updateData(newName: String, gender: String?, currentUser: Person?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {return}
        currentUser?.name = newName
        currentUser?.gender = gender

        do {
            try context.save()
            print("Data has been updated")
        } catch {
            print("Error has been occured during updating: \(error)")
        }
    }

    //MARK: - Getting inputting data from storage
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

    //MARK: - Deleting exact data from storage
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
