//
//  RequestsPageVC.swift
//  UTrain
//
//  Created by osx on 27/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
protocol updateView {
    
    func updateHeader(index:Int)
}

class RequestsPageVC: UIPageViewController {
    var customDelegate: updateView?
    var currentIndex = 1
    
    lazy var page: [UIViewController] = {
        return []
    }()
    
    private var eventsController  : EventsViewController? = EventsViewController.instance()
    private var sessionsController : SessionsViewController? =  SessionsViewController.instance()
    private var placesController : PlacesViewController? =  PlacesViewController.instance()
    private var servicesController : ServicesViewController? =  ServicesViewController.instance()

    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsController?.view.tag   = 1
        sessionsController?.view.tag = 2
        placesController?.view.tag   = 3
        servicesController?.view.tag = 4
        
        page.append(eventsController!)
        page.append(sessionsController!)
        page.append(placesController!)
        page.append(servicesController!)
        
        self.dataSource = self
        self.delegate = self
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
    
    private func getController(tabOption: RequestsViewController.child)->UIViewController
    {
        switch tabOption {
        case .current:
            return eventsController!
        case .additional:
            return sessionsController!
        case .third:
            return placesController!
        case .fourth:
            return servicesController!
        }
        
    }
    
    func selectTab(_ tabOption: RequestsViewController.child) {
        
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
        print("tag of the controller is \(self.currentIndex)")
        customDelegate?.updateHeader(index: self.currentIndex)
        self.setViewControllers(controllerList, direction: direction, animated: true, completion: nil)
    }
 
}

extension RequestsPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
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
        
        print("current controller is \(pageViewController.viewControllers?.first?.view.tag)")
        print("previousViewControllers controller is \(previousViewControllers.first?.view.tag)")
        customDelegate?.updateHeader(index: pageViewController.viewControllers?.first?.view.tag ?? 0)
        
        
    }
    
}
