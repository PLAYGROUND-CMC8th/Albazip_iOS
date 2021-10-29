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
    @IBOutlet var btnStart: UIButton!
    
    var slides: [OnboardingData] = []
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
                   OnboardingData(title: "근무자 관리", description: "근무자의 스케줄과 시급을 설정하고, 업무\n리스트를 작성해 편리하게 인수인계 하세요.", image: #imageLiteral(resourceName: "imgOnboarding1")),
            OnboardingData(title: "실시간 근태보고", description: "업무 리스트를 작성하면 근무자가 업무를\n체크하고, 관리자는 업무 진행현황을\n실시간으로 확인할 수 있어요.", image: #imageLiteral(resourceName: "imgOnboarding2")),
            OnboardingData(title: "모두를 위한 소통창", description: "새로운 공지사항이나 변경사항을\n즉시 공유하고 확인 할 수 있어요.\n이제 모두가 연결된 환경에서 근무하세요!", image: #imageLiteral(resourceName: "imgOnboarding3"))
               ]
        setUI()
    }
    
    func setUI()  {
        pageControl.numberOfPages = slides.count
        pageControl.isEnabled = true
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        pageControl.currentPageIndicatorTintColor = .mainYellow
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        btnStart.isHidden = true
    }
    
    func checkPage(currentPage:Int) {
        if(currentPage==2){
            btnStart.isHidden = false
        }else{
            btnStart.isHidden = true
        }
        print(currentPage)
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
        btnStart.isHidden = false
        currentPage = 2
        pageControl.currentPage = currentPage
    }
    
    @IBAction func btnNext(_ sender: Any) {
        collectionView.isPagingEnabled = false
            currentPage += 1
            pageControl.currentPage = currentPage
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
        if(currentPage==2){
            btnStart.isHidden = false
        }else{
            btnStart.isHidden = true
        }
        print(currentPage)
        pageControl.currentPage = currentPage
    }
}

// MARK: - DataSource & Delegate
extension OnboardingWorkerVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingWorkerCollectionViewCell.identifier, for: indexPath) as? OnboardingWorkerCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-5, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        checkPage(currentPage: currentPage)
    }
}
