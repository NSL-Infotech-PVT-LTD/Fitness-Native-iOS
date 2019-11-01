//
//  AthleteDashboardPageVC.swift
//  UTrain
//
//  Created by osx on 24/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

protocol updation {
    
    func updateHeader(index:Int)
}

class AthleteDashboardPageVC: UIPageViewController {
    var customDeleg: updation?
    var currentIndex = 1

    lazy var page: [UIViewController] = {
        return []
    }()
    
    private var eventsController  : AthleteDashbEventsVC? = AthleteDashbEventsVC.instance()
    private var sessionsController : AthleteDashbSessionsVC? =  AthleteDashbSessionsVC.instance()
    private var spacesController : AthleteDashbSpacesVC? =  AthleteDashbSpacesVC.instance()

    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsController?.view.tag = 1
        sessionsController?.view.tag = 2
        spacesController?.view.tag = 3
        
        page.append(eventsController!)
        page.append(sessionsController!)
        page.append(spacesController!)
        
        self.delegate = self
        self.dataSource = self
        if let firstView = page.first {
            setViewControllers([firstView],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        currentIndex = 1
    }
}
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
    func selectTab(_ tabOption: AthleteDashboardVC.child) {
        
        guard let currentController = self.viewControllers?.last
            else{
                return
        }
        
        guard let currentIndex = page.index(of: currentController) else {
            return
        }
        
        let controller = getController(tabOption: tabOption)
        
        let controllerList = [controller]
        var direction : UIPageViewController.NavigationDirection = .forward
        
        if(tabOption.rawValue < currentIndex){
            direction = .reverse
        }
        
        self.currentIndex = controller.view.tag
        customDeleg?.updateHeader(index: self.currentIndex)
        self.setViewControllers(controllerList, direction: direction, animated: true, completion: nil)
    }
    
    private func getController(tabOption: AthleteDashboardVC.child)->UIViewController
    {
        switch tabOption {
        case .first:
            return eventsController!
        case .second:
            return sessionsController!
        case .third:
            return spacesController!
    
        }
        
    }
    

}

extension AthleteDashboardPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = page.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        //user is on the first view controller and he swiped left
        guard previousIndex >= 0 else {
            //return page.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard page.count > previousIndex else {
            return nil
        }
        
        return page[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = page.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = page.count
        
        // User is on the last view controller and swiped right
        guard orderedViewControllersCount != nextIndex else {
            //return page.first
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        currentIndex = nextIndex+1
        
        return page[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    
        customDeleg?.updateHeader(index: pageViewController.viewControllers?.first?.view.tag ?? 0)
        
        
    }
    
}
