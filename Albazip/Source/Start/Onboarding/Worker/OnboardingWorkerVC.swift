//
//  OnboardingWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

import Foundation
import UIKit

class OnboardingWorkerVC: UIViewController{
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    
    var data = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
    }
    func setUI()  {
        pageControl.isEnabled = true
        pageControl.pageIndicatorTintColor = .blurGray
        pageControl.currentPageIndicatorTintColor = .mainYellow
        collectionView.isPagingEnabled = true
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
    }
    func setDelegate()   {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingWorkerCollectionViewCell.nib(), forCellWithReuseIdentifier: OnboardingWorkerCollectionViewCell.identifier)
    }
    
    // 스크롤 페이지 설정
    private func definePage(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        print("current page>>>>>\(page)")
        self.pageControl.currentPage = page
        
        
    }
}

// MARK: - DataSource & Delegate
extension OnboardingWorkerVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingWorkerCollectionViewCell.identifier, for: indexPath) as? OnboardingWorkerCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.setCell(title: data[indexPath.row], sub: data[indexPath.row], imageName: "imgOnboarding2")
        
        pageControl.numberOfPages = 3
        
        return cell
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height =  collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - pageControl
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       definePage(scrollView)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        definePage(scrollView)
    }
}
