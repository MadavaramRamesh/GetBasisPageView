//
//  PageViewController.swift
//  GetBasisPageView
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//
import Foundation
import UIKit

class PageViewController: UIPageViewController {
    
    // MARK: - Properties
    fileprivate var items: [UIViewController] = []
    let helper = NetworkHelper()
    let dispatchGroup = DispatchGroup()
    var cardContentList :[CardContentModel]?
    let backgroundColor:[String] = ["#82E0AA","#F5B7B1", "#D7BDE2","#A9CCE3","#A3E4D7", "#A9DFBF","#FAD7A0", "#EDBB99","#D5DBDB"]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        //
        self.decoratePageControl()
        //
        self.getCardListFromServer()
        // dispatchGroup Notify when service call will complete..
        dispatchGroup.notify(queue: .main) {
            print("service call completed..")
            self.populateItems()
            if let firstViewController = self.items.first {
                self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Methods
    
    //API Call
    ///
    /// Makes an `GET`  service call to get `self.cardContentList` data
    ///
    func getCardListFromServer() {
        dispatchGroup.enter()
        helper.getCardList(controller: self, completionResult: {
            (success, responseData) in
            do {
                if success {
                    let dataJson = try JSONSerialization.data(withJSONObject: responseData as Any, options: [])
                    let responseObject = try JSONDecoder().decode(CardResponce.self, from: dataJson)
                    if(responseObject.data != nil) {
                        if let _ = responseObject.data {
                            self.cardContentList = responseObject.data
                            self.dispatchGroup.leave()
                            
                        }
                    }
                } else {
                    self.dispatchGroup.leave()
                    print("data is not available")
                }
            } catch {
                self.dispatchGroup.leave()
                print("catch error \(error)")
            }
        })
        
    }
    
    ///
    /// To Customise `Page Controller`
    ///
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [PageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    ///
    /// Display the contents on the `Card View`
    ///
    fileprivate func populateItems() {
        //Created n number of random color types
        let newColorsArray = [String](count: self.cardContentList!.count, repeatedValues: self.backgroundColor)
        var countString : String?
        for (index, t) in self.cardContentList!.enumerated() {
            countString = "Card: " + " " +  "\(index + 1)" + " of " + "\( self.cardContentList!.count)"
            let color = UIColor().colorFromHexString(newColorsArray?[index] ?? "#FBFCFC")
            items.append(createCardItemControler(with: t.text, with: color, with: countString))
        }
    }
    
    ///
    /// Creates new View controller for each item in the pageview
    ///
    
    fileprivate func createCardItemControler(with titleText: String?, with color: UIColor?,with progress:String?) -> UIViewController {
        let cardVC = UIViewController()
        cardVC.view = CardItem(titleText: titleText, background: color,progress:progress)
        return cardVC
    }
}

// MARK: - DataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return items.last
        }
        guard items.count > previousIndex else {
            return nil
        }
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        guard items.count > nextIndex else {
            return nil
        }
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}
