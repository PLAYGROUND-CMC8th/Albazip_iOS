//
//  OnboardingManagerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/28.
//

import Foundation
import UIKit
class OnboardingManagerVC:UIViewController{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextBtn: UIButton!
    
    var slides: [OnboardingData] = []
    
    var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
                if currentPage == slides.count - 1 {
                    nextBtn.setTitle("Get Started", for: .normal)
                } else {
                    nextBtn.setTitle("Next", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
                   OnboardingData(title: "Delicious Dishes", description: "Experience a variety of amazing dishes fr", image: #imageLiteral(resourceName: "imgOnboarding2")),
            OnboardingData(title: "World-Class Chefs", description: "Our dish", image: #imageLiteral(resourceName: "imgOnboarding3")),
            OnboardingData(title: "Instant World-Wide Delivery", description: "You", image: #imageLiteral(resourceName: "imgOnboarding1"))
               ]
        pageControl.numberOfPages = slides.count
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    @IBAction func btnNext(_ sender: Any) {
        if currentPage == slides.count - 1 {
                    print("다음 페이지로..")
                } else {
                    currentPage += 1
                    let indexPath = IndexPath(item: currentPage, section: 0)
                    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }
    }
    

extension OnboardingManagerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
