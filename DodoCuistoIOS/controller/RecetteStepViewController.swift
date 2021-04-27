//
//  RecetteStepViewController.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 23/04/2021.
//

import UIKit

class RecipeStepViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageContainer: UIPageViewController!
    
    var pages = [UIViewController]()
    
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    /*var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let recipe = recipe {
            for step in recipe.steps {
                let page: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "stepViewController")
                if let page = page as? StepViewController {
                    page.recipeID = recipe.id
                    page.step = step
                }
                pages.append(page)
            }
        }
        
        let endPage: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "finishStepViewController")
        if let endPage = endPage as? FinishViewController {
            endPage.recipe = recipe
            pages.append(endPage)
        }
        
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        if let first = pages.first {
            pageContainer.setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
        
        self.addChildViewController(pageContainer)
        view.addSubview(pageContainer.view)
        
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == pages.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SpeechViewController {
            destinationViewController.recipe = recipe
        }
    }*/
}
