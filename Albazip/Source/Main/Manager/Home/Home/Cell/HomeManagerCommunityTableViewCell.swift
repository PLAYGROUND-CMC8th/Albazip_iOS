//
//  HomeManagerCommunityTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

//MARK: Protocol
protocol HomeCommunityViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: HomeManagerCoummunityCollectionViewCell?, index: Int, didTappedInTableViewCell: HomeManagerCommunityTableViewCell)
    func goCommunityPage()
}

class HomeManagerCommunityTableViewCell: UITableViewCell {
    var currentPage = 0
    // 스크롤
    let behavior = MSCollectionViewPeekingBehavior()
    // 프로토콜 변수
    weak var delegate: HomeCommunityViewCellDelegate?
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var bottomPadding: NSLayoutConstraint!
    
    var isNoData = true

    var data = [HomeWorkerBoardInfo]()
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
        //pageControl.numberOfPages = 5
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
        delegate?.goCommunityPage()
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
        if isNoData{
            return 1
        }else{
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isNoData{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeManagerCoummunityCollectionViewCell", for: indexPath) as? HomeManagerCoummunityCollectionViewCell {
                //cell.setCell(boardInfo: data[indexPath.row])
                cell.titleLabel.text = "작성된 공지사항이 없어요."
                cell.statusWidth.constant = 0
                cell.titleLabel.textColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
                cell.statusLabel.isHidden = true
                return cell
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeManagerCoummunityCollectionViewCell", for: indexPath) as? HomeManagerCoummunityCollectionViewCell {
                cell.setCell(boardInfo: data[indexPath.row])
                cell.titleLabel.textColor = #colorLiteral(red: 0.22350353, green: 0.2235475481, blue: 0.2234977186, alpha: 1)
                cell.statusLabel.isHidden = false
                return cell
            }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("콜렉션 뷰 " + String(indexPath.row))
        
        let cell = collectionView.cellForItem(at: indexPath) as? HomeManagerCoummunityCollectionViewCell
        self.delegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)

    }
    //데이터 가져올 함수
    func setCell(boardInfo: [HomeWorkerBoardInfo])  {
        data = boardInfo
        if data.count == 0{
            isNoData = true
            pageControl.isHidden = true
        }else{
            isNoData = false
            pageControl.isHidden = false
            pageControl.numberOfPages = data.count
        }
        
        self.collectionView.reloadData()
    }
}
