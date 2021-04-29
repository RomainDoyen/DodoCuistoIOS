//
//  ViewController.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 23/04/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func getStringDataFromName(name: String) -> Any {
        let asset = NSDataAsset(name: name, bundle: Bundle.main)
        return String(data: asset!.data, encoding: .utf8)!
    }
    
    func getJsonDataFromName(name: String) -> [Any] {
        let asset = NSDataAsset(name: name, bundle: Bundle.main)
        return try! JSONSerialization.jsonObject(with: asset!.data, options: []) as! [Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showSpinner(onView: self.view)
        DispatchQueue.global(qos: .background).async {
            let categoryStr = self.getJsonDataFromName(name: "categories")
            let recipePreviewStr = self.getJsonDataFromName(name: "recipePreviews")
            RecetteController.LoadAllCategories(jsonWithArrayRoot: categoryStr)
            RecetteController.LoadAllRecipePreviews(jsonWithArrayRoot: recipePreviewStr)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToTabBar", sender: self)
                self.removeSpinner()
            }
            RecetteController.Group.enter()
            RecetteController.LoadAllRecipeDetails(jsonWithArrayRoot: self.getJsonDataFromName(name: "recipeDetails"))
            RecetteController.Group.leave()
        }
    }
}

