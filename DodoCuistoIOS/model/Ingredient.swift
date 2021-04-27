//
//  Ingredient.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 23/04/2021.
//

import Foundation

public class Ingredient {
    
    public let id: Int
    
    public let name: String
    
    public let productName: String
    
    public let unit: Unit
    
    public let properties: [IngredientProperty]
    
    public let canAddToPantry: Bool
    
    private init(id: Int, name: String, productName: String, unit: Unit, properties: [IngredientProperty], canAddToPantry: Bool) {
        self.id = id
        self.name = name
        self.productName = productName
        self.unit = unit
        self.properties = properties
        self.canAddToPantry = canAddToPantry
    }
    
    private static var cache: [Int: Ingredient] = [:]
    
    public class func fromJson(jsonData: HttpUtils.JsonObject) -> Ingredient? {
        guard let id = jsonData["id"] as? Int else {
            return nil
        }
        
        if (cache[id] != nil) {
            return cache[id]
        }
        
        guard let name = jsonData["displayname"] as? String else {
            return nil
        }
        guard let productName = jsonData["productname"] as? String else {
            return nil
        }
        guard let propertiesData = jsonData["property"] as? HttpUtils.JsonArray else {
            return nil
        }
        var properties: [IngredientProperty] = []
        for data in propertiesData {
            if let property = IngredientProperty.fromJson(jsonData: data) {
                properties.append(property)
            }
        }
        
        guard let unitData = jsonData["unit"] as? HttpUtils.JsonObject else {
            return nil
        }
        guard let unit = Unit.fromJson(jsonData: unitData) else {
            return nil
        }
        guard let canAddToPantry = jsonData["canAddToPantry"] as? Bool else {
            return nil
        }
    
        cache[id] = Ingredient(id: id, name: name, productName: productName, unit: unit, properties: properties, canAddToPantry: canAddToPantry)
        return cache[id]
    }
}

extension Ingredient {
    
    public func hasOffer() -> Bool {
        var isOffer = false
        for offer in MarketOffer.offers {
            for word in offer.name.components(separatedBy: " ") {
                if (word as NSString).scoreAgainst(productName) > 0.9 {
                    isOffer = true
                }
            }
        }
        return isOffer
    }
}
