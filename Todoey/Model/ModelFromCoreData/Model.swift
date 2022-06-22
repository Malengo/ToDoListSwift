
import Foundation
import CoreData
import UIKit

protocol ManagedObject {
    func read() -> [NSManagedObject]
    func delete(entity: NSManagedObject)
}

class Model<U: NSManagedObject>: NSManagedObject, ManagedObject {
    
    var resquest: NSFetchRequest<U> = NSFetchRequest<U>(entityName: String(describing: U.self))
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func read() -> [NSManagedObject] {
        var category = [U]()
        do {
            category = try context.fetch(resquest)
            return category
        } catch {
            print("Error to getAll Categories")
            return []
        }
    }
    
    func save() {
        do{
            try context.save()
        } catch {
            print("Error to Save \(error)")
        }
    }
    
    func delete(entity: NSManagedObject) {
        context.delete(entity)
        save()
    }
    
    
}
