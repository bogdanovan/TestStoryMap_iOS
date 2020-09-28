//
//  DataBaseHelper.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 28.09.2020.
//

import UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
    
    func deleteImage() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            for object in result {
                context.delete(object)
            }
        } catch {
            print("Error while deleting the image")
        }
    }
}
