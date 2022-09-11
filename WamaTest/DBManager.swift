//
//  DBManager.swift
//  WamaTest
//
//  Created by Prakash on 31/05/22.
//

import Foundation
import CoreData
import UIKit
class DBManager{
    static var sharedInstance = DBManager()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    //save article in DB
    func save(arrArticles:[Article],completionHandler:@escaping(_ msg:String?,_ error:Error?)->()){
        
        if arrArticles.count > 0{
            for article in arrArticles{
                let newsArticle = NSEntityDescription.insertNewObject(forEntityName: "NewsArticle", into: context!) as! NewsArticle
                newsArticle.url = article.url
                newsArticle.author = article.author
                newsArticle.title = article.title
                newsArticle.content = article.content
                newsArticle.descriptions = article.articleDescription
                newsArticle.publishedAt = article.publishedAt
                newsArticle.urlToImage = article.urlToImage
                newsArticle.url = article.url
                newsArticle.like = false
                newsArticle.dislike = false
            }
        }
        do {
            try context?.save()
            completionHandler("Saved",nil)
           } catch {
               completionHandler(nil,error)
               print("Error saving: \(error)")
           }
    }
    
    
    //fetch data from DB
    func fetchAllData()->[NewsArticle]{
        var empArr = [NewsArticle]()

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsArticle")
        do {
             empArr = try context?.fetch(fetchRequest) as! [NewsArticle]

        }catch {
            print("Error====\(error)")
        }
        return empArr
    }
    
    //update like and dislike in DB
    func likeDislike(buttonType:ButtonType,index:Int)->Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsArticle")
        do{
            let list = try context?.fetch(fetchRequest) as! [NewsArticle]
            if list.count != 0 {
                let objectUpdate = list[index] as NSManagedObject
                if buttonType == .like{
                    objectUpdate.setValue(true, forKey: "like")
                    objectUpdate.setValue(false, forKey: "dislike")
                }
                else if buttonType == .dislike{
                    objectUpdate.setValue(false, forKey: "like")
                    objectUpdate.setValue(true, forKey: "dislike")
                }
                do{
                    try context?.save()
                    return true
                }catch{
                    return false
                }
            }
        }catch{
            return false
        }
        return false
    }
}
