//
//  CategorieController.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 29/04/2021.
//

import UIKit

class CategorieController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var resourceImageLst : Dictionary<Int, UIImage> = Dictionary<Int, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        self.title = ""
        self.parent?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationItem.title = "Recette Créoles"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RecetteCategorie.CurrentCategoryId = RecetteCategorie.CategoriesInstance?[indexPath.item].Id ?? -1
        RecetteCategorie.CurrentCategoryName = RecetteCategorie.CategoriesInstance?[indexPath.item].CategoryName ?? ""
        performSegue(withIdentifier: "goToRecipeList", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section : Int) -> Int {
        return (RecetteCategorie.CategoriesInstance?.count)!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
        let categoryItem = RecetteCategorie.CategoriesInstance?[indexPath.item]
        cell.lblTitle.text = categoryItem?.CategoryName
        cell.lblDescription.text = String(format: "(%d)", RecetteCategorie.CategoryCounter![categoryItem!.Id] ?? 0)
        let url = URL(string: (categoryItem!.BgImg)!)
        
        if self.resourceImageLst[(categoryItem!.Id)!] == nil
        {
            cell.previewImage.setLoadingAnimation()
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async() {
                    let image = UIImage(data: data)
                    cell.previewImage.setImage(image: image!)
                    self.resourceImageLst[(RecipeManager.CategoriesInstance?[indexPath.item].Id)!] = image
                }
            }
            task.resume()
        }
        else
        {
            cell.previewImage.image = self.resourceImageLst[(RecetteCategorie.CategoriesInstance?[indexPath.item].Id)!]
        }
        
        cell.previewImage.layer.cornerRadius = 8.0
        cell.previewImage.clipsToBounds = true
       
        return cell
    }
    

}
