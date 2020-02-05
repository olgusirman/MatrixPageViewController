//
//  PageViewControllerVertical.swift
//  LinkedPageExample
//
//  Created by Olgu on 28.01.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

import UIKit

final class PageViewControllerVertical: UIPageViewController {
    
    var pages: [UIViewController] = [] {
        didSet {
            preparePages()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        preparePages()
    }
    
    func preparePages() {
        
        // If you want to start from median
        //let median = Int(pages.count / 2)
        //let medianElement = pages[median]
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

// MARK: Vertical PageViewController Delegate
extension PageViewControllerVertical: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}

extension PageViewControllerVertical: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 && pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pagesCount = pages.count
        
        guard pagesCount != nextIndex && pagesCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
}

