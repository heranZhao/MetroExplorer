//
//  PresistenceManager.swift
//  Metro Explorer
//
//  Created by heran zhao on 11/24/18.
//  Copyright © 2018 heran zhao. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let businessesKey = "Business"
    
    func saveWorkout(business: Businesses) {
        let userDefaults = UserDefaults.standard
        
        var businesses = fetchFavoriteBusinesses()
        
        if businesses.index(where: { $0.id == business.id }) != nil
        {
            return
        }
        
        businesses.append(business)
        
        let encoder = JSONEncoder()
        let encodedBusinesses = try? encoder.encode(businesses)
        
        userDefaults.set(encodedBusinesses, forKey: businessesKey)
    }
    
    
    func fetchFavoriteBusinesses() -> [Businesses] {
        let userDefaults = UserDefaults.standard
        
        if let businessData = userDefaults.data(forKey: businessesKey), let businesses = try? JSONDecoder().decode([Businesses].self, from: businessData) {
            return businesses
        }
        else {
            return [Businesses]()
        }
    }
    
    func unCheckFavorite(business: Businesses)
    {
        var savedList = fetchFavoriteBusinesses()
        
        if let index = savedList.index(where: { $0.id == business.id })
        {
            savedList.remove(at: index)
        }
        
        let encoder = JSONEncoder()
        let encodedBusinesses = try? encoder.encode(savedList)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedBusinesses, forKey: businessesKey)
    }
    
    func checkIsFavorite(business: Businesses) -> Bool
    {
        let savedList = fetchFavoriteBusinesses()
        return savedList.contains { (element) -> Bool in
            element.id == business.id
        }
    }
     
}
