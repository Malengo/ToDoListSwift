//
//  CategoryModel.swift
//  Todoey
//
//  Created by user on 15/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CategoryModelProtocol {
    func create(entity: String) -> Category
    func read() -> [Category]
    func delete(entity: Category)
}



struct CategoryModel: CategoryModelProtocol {
     
    var resquest: NSFetchRequest<Category> = Category.fetchRequest()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func create(entity: String) -> Category {
        let category = Category(context: self.context)
        category.name = entity
        try? context.save()
        return category
    }
    
    func read() -> [Category] {
        var category = [Category]()
        do {
            category = try context.fetch(resquest)
            return category
        } catch {
            print("Error to getAll Categories")
            return []
        }
    }
    
    func delete(entity: Category) {
        context.delete(entity)
        try? context.save()
    }
    
    
}
