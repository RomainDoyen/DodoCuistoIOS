//
//  RecetteCategorie.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 27/04/2021.
//

import Foundation

public class RecetteCategorie {
    public static var Instance : Array<RecetteCategorie>? = Array<RecetteCategorie>()
    public static var CurrentCategoryId : Int = -1
    public static var CurrentCategoryName : String = ""
    
    public var Id : Int!
    public var CategoryName : String!
    public var BgImg : String!
    public var TotalOfRecipes : Int!
    
    public init(id : Int!, categoryName : String!, bgImg : String!, totalOfRecipes : Int!)
    {
        self.Id = id
        self.CategoryName = categoryName
        self.BgImg = bgImg
        self.TotalOfRecipes = totalOfRecipes
    }
    
    public init?(json: [String: Any]) {
        guard let id = json["Id"] as? Int,
            let categoryName = json["CategoryName"] as? String,
            let bgImageUrl = json["BgImageUrl"] as? String
        else {
            return nil
        }
        self.Id = id
        self.CategoryName = categoryName
        self.BgImg = bgImageUrl
        self.TotalOfRecipes = 0
    }
}
