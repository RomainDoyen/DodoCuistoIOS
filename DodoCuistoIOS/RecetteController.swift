//
//  RecetteController.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 29/04/2021.
//

import Foundation

public class RecetteController {
    public static var CategoriesInstance : Array<Category>? = Array<Category>()
    public static var RecipesPreviewInstance : Array<RecetteView>? = Array<RecetteView>()
    public static var RecipesDetailInstance : Array<RecetteView>? = Array<RecetteView>()
    public static var CurrentRecipe : RecetteView?
    public static var CurrentCategoryId : Int = -1
    public static var CurrentCategoryName : String = ""
    public static var CategoryCounter : Dictionary<Int, Int>? = Dictionary<Int, Int>()
    public static let Group = DispatchGroup()

    public static func LoadAllCategories(jsonWithArrayRoot: [Any]) {
        for objectItem in jsonWithArrayRoot {
            CategoriesInstance?.append(Category(json: objectItem as! [String : Any])!)
        }
    }
    
    public static func LoadAllRecipePreviews(jsonWithArrayRoot: [Any]) {
        for objectItem in jsonWithArrayRoot {
            var recipePreview = RecetteView(json: objectItem as! [String : Any])!
            RecipesPreviewInstance?.append(recipePreview)
            if (CategoryCounter![recipePreview.CategoryId] == nil) {
                CategoryCounter![recipePreview.CategoryId] = 0
            }
            CategoryCounter![recipePreview.CategoryId]! += 1
        }
    }
    public static func LoadAllRecipeDetails(jsonWithArrayRoot: [Any]) {
        for objectItem in jsonWithArrayRoot {
            var recetteView = RecetteView(json: objectItem as! [String : Any])!
            RecipesDetailInstance?.append(recetteView)
        }
    }
}
