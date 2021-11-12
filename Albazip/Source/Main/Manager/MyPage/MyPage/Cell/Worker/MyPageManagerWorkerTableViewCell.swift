//
//  MyPageManagerWorkerTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/02.
//

import UIKit
//MARK: Protocol
protocol MyPageManagerWorkerCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: MyPageManagerWorkerCollectionViewCell?, index: Int, didTappedInTableViewCell: MyPageManagerWorkerTableViewCell)
}

class MyPageManagerWorkerTableViewCell: UITableViewCell {

    
    @IBOutlet var totalCount: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    weak var myPageManagerWorkerCollectionViewCellDelegate : MyPageManagerWorkerCollectionViewCellDelegate?
    
    // 데이터 배열
    var contentData: Array<MyPageManagerContentData> = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - Helpers
    func setNib()  {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "MyPageManagerWorkerCollectionViewCell", bundle: nil)
                self.collectionView.register(cellNib, forCellWithReuseIdentifier: "MyPageManagerWorkerCollectionViewCell")
    }
}

//MARK: 테이블 뷰 셀 extension
extension MyPageManagerWorkerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return contentData.count
        //return movieVO.popular.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let width = collectionView.bounds.width / 3.3
        return CGSize(width: width, height: 143)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageManagerWorkerCollectionViewCell", for: indexPath) as? MyPageManagerWorkerCollectionViewCell {
            
            cell.setCell(data: contentData[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("콜렉션 뷰 " + String(indexPath.row))
        
        let cell = collectionView.cellForItem(at: indexPath) as? MyPageManagerWorkerCollectionViewCell
            self.myPageManagerWorkerCollectionViewCellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)

    }
    
    //데이터 가져올 함수
    func setCell(data: Array<MyPageManagerContentData>)  {
        self.contentData = data
        self.collectionView.reloadData()
    }
}
