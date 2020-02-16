//
//  NewsManager.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/2/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewsManager {
    var newsEvents: [NewsInfo] = Array.init()
    
    public static let sharedInstance = NewsManager.init()
    
    init() {
        self.loadData()
        refreshNews()
    }
    
    func numberOfEvents() -> Int {
        return self.newsEvents.count
    }
    
    func eventAtIndex(_ index: Int) -> NewsInfo? {
        if index >= newsEvents.count {
            return nil
        }
        
        return self.newsEvents[index]
    }
    
    public func refreshNews(withSuccess successBlock: (() -> (Void))?, errorBlock: (() -> (Void))?) {
        NetworkManager.getNews(successBlock: { (news) -> (Void) in
            if news != nil && (news?.count)! > 0 {
                self.deleteData()
                self.newsEvents.removeAll()
                self.newsEvents = news!
                self.newsEvents.sort(by: { (item1, item2) -> Bool in
                    return item1.timestamp! > item2.timestamp!
                })
                self.saveData()
                
                if successBlock != nil {
                    successBlock!()
                }
            }
        }) { () -> (Void) in
            if errorBlock != nil {
                errorBlock!()
            }
        }
    }
    
    private func refreshNews() {
        self.refreshNews(withSuccess: nil, errorBlock: nil)
    }
    
    private func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for newsEvent in self.newsEvents {
            let entity = NSEntityDescription.entity(forEntityName: "NewsInfoModel", in: managedContext)!
            let newsInfoModel = NSManagedObject(entity: entity, insertInto: managedContext)
            
            newsInfoModel.setValue(newsEvent.title, forKeyPath: "title")
            newsInfoModel.setValue(newsEvent.timestamp, forKeyPath: "timestamp")
            newsInfoModel.setValue(newsEvent.description, forKeyPath: "details")
            newsInfoModel.setValue(newsEvent.images, forKeyPath: "images")
            
            if newsEvent.link != nil {
                newsInfoModel.setValue(newsEvent.link?.title, forKeyPath: "linkTitle")
                newsInfoModel.setValue(newsEvent.link?.url, forKeyPath: "linkUrl")
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    private func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsInfoModel")
        
        var newsInfoModels: [NSManagedObject] = []
        
        do {
            newsInfoModels = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        var newsEvents: [NewsInfo] = []
        for newsInfoModel in newsInfoModels {
            let title = newsInfoModel.value(forKey: "title") != nil ? (newsInfoModel.value(forKey: "title") as! String) : nil
            let timestamp = newsInfoModel.value(forKey: "timestamp") != nil ? (newsInfoModel.value(forKey: "timestamp") as! String) : nil
            let description = newsInfoModel.value(forKey: "details") != nil ? (newsInfoModel.value(forKey: "details") as! String) : nil
            let images = newsInfoModel.value(forKey: "images") != nil ? (newsInfoModel.value(forKey: "images") as! [String]) : nil
            
            let linkTitle = newsInfoModel.value(forKey: "linkTitle") != nil ? (newsInfoModel.value(forKey: "linkTitle") as! String) : nil
            let linkUrl = newsInfoModel.value(forKey: "linkUrl") != nil ? (newsInfoModel.value(forKey: "linkUrl") as! String) : nil
            
            
            let newsLink: NewsLink?
            if linkTitle != nil && linkUrl != nil {
                newsLink = NewsLink.init(title: linkTitle, url: linkUrl)
            } else {
                newsLink = nil
            }
            
            let newsInfo = NewsInfo.init(timestamp: timestamp, title: title, description: description, images: images, link: newsLink)
            
            newsEvents.append(newsInfo)
        }
        
        self.newsEvents = newsEvents
    }
    
    private func deleteData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsInfoModel")
        let batchDeleteRequest = NSBatchDeleteRequest.init(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
    }
}
