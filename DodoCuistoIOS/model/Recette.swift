//
//  Recette.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 23/04/2021.
//

import Foundation

public class Recette {
    
    public let id: Int
   
    public let name: String
    
    public let steps: [Step]
    
    public let time: Int
    
    public let difficulty: Int
    
    public init(id: Int, name: String, steps: [Step], time: Int, difficulty: Int) {
        self.id = id
        self.name = name
        self.steps = steps
        self.time = time
        self.difficulty = difficulty
    }
    
    public var ingredients: [IngredientUse] {
        return steps.flatMap { return $0.ingredients }
    }

    public var price: Double {
        let prices = ingredients.map({return $0.price})
        return prices.reduce(0, +)
    }
    
    public class func fromJson(jsonData: HttpUtils.JsonObject) -> Recipe? {
        
        guard let id = jsonData["id"] as? Int else {
            return nil
        }
        guard let name = jsonData["name"] as? String else {
            return nil
        }
        guard let time = jsonData["time"] as? Int else {
            return nil
        }
        guard let difficulty = jsonData["difficulty"] as? Int else {
            return nil
        }
        
        
        guard let stepsData = jsonData["steps"] as? HttpUtils.JsonArray else {
            return nil
        }
        var steps: [Step] = []
        for item in stepsData {
            if let step = Step.formJson(jsonData: item) {
                steps.append(step)
            }
        }
        
        steps.sort {$0.order < $1.order }

        return Recette(id: id, name: name, steps: steps, time: time, difficulty: difficulty)
    }
}

extension Recette {
    
    public var priceFormatted: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: price as NSNumber) ?? ""
    }
}


extension Recette {
    
    public func done() {
        for ingredient in ingredients {
            if ingredient.ingredient.canAddToPantry && ingredient.ingredient.unit != .Ohne {
                if let pantryItem = PantryItem.find(ingredient: ingredient.ingredient) {
                    pantryItem.delete(amount: ingredient.amount)
                }
            }
        }
    }
    
    public func hasAllIngredients() -> Bool {
        for ingredient in ingredients {
            if ingredient.ingredient.canAddToPantry {
                guard let pantryItem = PantryItem.find(ingredient: ingredient.ingredient) else {
                    return false
                }
                if pantryItem.amount < ingredient.amount {
                    return false
                }
            }
        }
        return true
    }
}
