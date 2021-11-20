//
//  HomeManagerCommunityTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
class HomeManagerCommunityTableViewCell: UITableViewCell {
    var currentPage = 0
    // 스크롤
    let behavior = MSCollectionViewPeekingBehavior()
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUI(){
        pageControl.numberOfPages = 5
        pageControl.isEnabled = true
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        pageControl.currentPageIndicatorTintColor = .mainYellow
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        // 스크롤 시 빠르게 감속 되도록 설정
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        
        let cellNib = UINib(nibName: "HomeManagerCoummunityCollectionViewCell", bundle: nil)
                self.collectionView.register(cellNib, forCellWithReuseIdentifier: "HomeManagerCoummunityCollectionViewCell")
        behavior.cellSpacing = 0
        behavior.cellPeekWidth = 0
        behavior.numberOfItemsToShow = 1
        collectionView.configureForPeekingBehavior(behavior: behavior)
    }
    @IBAction func btnGoCommunity(_ sender: Any) {
    }
    func checkPage(currentPage:Int) {
        if(currentPage == 2){
            //btnStart.isHidden = false
        }else{
            //btnStart.isHidden = true
        }
        print(currentPage)
        pageControl.currentPage = currentPage
    }
}
extension HomeManagerCommunityTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeManagerCoummunityCollectionViewCell", for: indexPath) as? HomeManagerCoummunityCollectionViewCell {
            
            //cell.setCell( sale: saleArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-5, height: collectionView.frame.height)
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }*/
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        checkPage(currentPage: currentPage)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
