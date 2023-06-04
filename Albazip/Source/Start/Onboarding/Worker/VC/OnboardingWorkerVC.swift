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
        Firebase.Log.signupEmployeeOnboarding.event()
        
        slides = [
                   OnboardingData(title: "업무 체크", description: "업무 리스트를 체크하고, 하루에\n주어진 업무를 빼먹지 않고 수행할 수 있어요.", image: #imageLiteral(resourceName: "imgOnboarding1")),
            OnboardingData(title: "근무일 및 급여 확인", description: "QR체크를 통한 출퇴근 기록으로\n정확한 근무한 날과 시간이 기록돼요!\n또한 이 달에 받을 급여를 미리 알 수 있어요.", image: #imageLiteral(resourceName: "imgOnboarding2")),
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
        pageControl.currentPage = currentPage
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
    @IBAction func btnStart(_ sender: Any) {
        let newStoryboard = UIStoryboard(name: "MainWorker", bundle: nil)
        let newViewController = newStoryboard.instantiateViewController(identifier: "MainWorkerTabBarController")
        self.changeRootViewController(newViewController)
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
