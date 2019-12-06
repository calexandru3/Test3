//
//  CustonPangeViewController.swift
//  Test3
//
//  Created by Bogdan Marica on 06/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController {

    var pages:Array<PageModel>?

    var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.isUserInteractionEnabled = false

        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    fileprivate func setUp(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "Page View"
        self.dataSource = self
        self.delegate = self
        if let firstPage = pages?.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }

        self.view.addSubview(pageControl)
        pageControl.numberOfPages = pages!.count
        self.view.bringSubviewToFront(pageControl)

        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

}

extension CustomPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages!.firstIndex(of: page as! PageModel)!
    }
}

extension CustomPageViewController: UIPageViewControllerDataSource{

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pages!.firstIndex(of: viewController as! PageModel) else { return nil}
        let prevIndex = pageIndex - 1

        if prevIndex < 0 {
            return pages!.last
        } else {
            return pages![prevIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pages!.firstIndex(of: viewController as! PageModel) else { return nil}
        let nextIndex = pageIndex + 1

        if nextIndex > pages!.count-1 {
            return pages!.first
        } else {
            return pages![nextIndex]
        }
    }
}
