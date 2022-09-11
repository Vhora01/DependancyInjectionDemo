//
//  NewsArticle+CoreDataProperties.swift
//  WamaTest
//
//  Created by Prakash on 01/06/22.
//
//

import Foundation
import CoreData


extension NewsArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsArticle> {
        return NSFetchRequest<NewsArticle>(entityName: "NewsArticle")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var like: Bool
    @NSManaged public var dislike: Bool
}

extension NewsArticle : Identifiable {

}
