//
//  HomeViewController.swift
//  LinkedPageExample
//
//  Created by Olgu on 28.01.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var cachedCurrentViewControllerForPrepareHorizontalMove: ViewController?
    
    var firstHorizontalPages: [ViewController] {
        return
            [createFirstHorizontals(verticalIndex: 0),
             createFirstHorizontals(verticalIndex: 1),
             createFirstHorizontals(verticalIndex: 2)]
    }
    
    var allVerticals: [PageViewControllerVertical] = []
    
    let allPages = [
        [HomeViewController.create(setIndex: Node(x: 0, y: 0)),
         HomeViewController.create(setIndex: Node(x: 0, y: 1)),
         HomeViewController.create(setIndex: Node(x: 0, y: 2))],
        
        [HomeViewController.create(setIndex: Node(x: 1, y: 0)),
         HomeViewController.create(setIndex: Node(x: 1, y: 1)),
         HomeViewController.create(setIndex: Node(x: 1, y: 2))],
        
        [HomeViewController.create(setIndex: Node(x: 2, y: 0)),
         HomeViewController.create(setIndex: Node(x: 2, y: 1)),
         HomeViewController.create(setIndex: Node(x: 2, y: 2))]
    ]
    
    var horizontal: PageViewControllerHorizontal?
    
    private func createFirstHorizontals(verticalIndex: Int) -> ViewController {
        let activityController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
        configureVerticalPageViewController(inside: activityController, with: allPages[verticalIndex])
        return activityController
    }
    
    static private func create(setIndex: Node) -> ViewController {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
        vc.node = setIndex
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        configureHorizontalPageViewController(inside: self, with: firstHorizontalPages)
    }
    
    private func configureVerticalPageViewController(inside controller: UIViewController, with pages: [UIViewController]) {
        let verticalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PageViewControllerVertical") as! PageViewControllerVertical
        verticalViewController.delegate = self
        verticalViewController.pages = pages
        controller.addChild(verticalViewController)
        controller.view.addSubview(verticalViewController.view)
        controller.didMove(toParent: verticalViewController)
        allVerticals.append(verticalViewController)
    }
    
    private func configureHorizontalPageViewController(inside controller: UIViewController, with pages: [UIViewController]) {
        let horizontalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PageViewControllerHorizontal") as! PageViewControllerHorizontal
        horizontalViewController.delegate = self
        horizontalViewController.pages = pages
        controller.addChild(horizontalViewController)
        controller.view.addSubview(horizontalViewController.view)
        controller.didMove(toParent: horizontalViewController)
        self.horizontal = horizontalViewController
    }
    
}

extension HomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pending = pendingViewControllers.first as? ViewController, pageViewController is PageViewControllerVertical else {
            return
        }
        cachedCurrentViewControllerForPrepareHorizontalMove = pending
        debugPrint("\(#function) \(pageViewController), pendingNode \(pending.node)")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let previousVC = previousViewControllers.first as? ViewController else {
            return
        }
        
        guard let cached = cachedCurrentViewControllerForPrepareHorizontalMove,
            completed && ( cached != previousVC ) else {
            return
        }
        
        // horizontalController next index should be the same index with cached one
        for vertical in allVerticals {
            for page in vertical.pages {
                if let page = page as? ViewController {
                    
                    // Move all Y axis, except from current
                    if page.node.x != cached.node.x {
                        let updated = vertical.pages[cached.node.y]
                        
                        // Update all vertical inside the same line apart from from current
                        vertical.setViewControllers([updated], direction: .forward, animated: false, completion: nil)
                        debugPrint("Set the horizontalController next index should be the same index with cached one cached = \(cached.node)")
                        
                    }
                }
            }
        }
        cachedCurrentViewControllerForPrepareHorizontalMove = nil
    }
    
}
