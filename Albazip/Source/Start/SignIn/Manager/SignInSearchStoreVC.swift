//
//  SignInSearchStoreVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class SignInSearchStoreVC: UIViewController{
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //선택된 컬렉션뷰
    var selectedOne = 0
    
    //스크롤 action
    let behavior = MSCollectionViewPeekingBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCollectionView()
        
    }
    
    func setUI(){
        let attrString = NSMutableAttributedString(string: alertLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        alertLabel.attributedText = attrString
        searchTextField.addLeftPadding()
        cornerView.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        behavior.cellSpacing = 8
        behavior.cellPeekWidth = 17
        behavior.numberOfItemsToShow = 1
        collectionView.configureForPeekingBehavior(behavior: behavior)
    }
}

extension SignInSearchStoreVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell {
            if(indexPath.row == selectedOne){
                cell.searchView.backgroundColor = .semiYellow
                cell.searchView.borderColor = .mainYellow
                
            }else{
                cell.searchView.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
                cell.searchView.borderColor = #colorLiteral(red: 0.8077629209, green: 0.8078994155, blue: 0.8077449799, alpha: 1)
            }
            cell.titleLabel.text = "Label\(indexPath.row)"
            cell.subLabel.text = "Label\(indexPath.row)"
            return cell
        }
        return UICollectionViewCell()
    }
    
    //스크롤뷰
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        print("지도 뷰 변환: " + String(behavior.currentIndex))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("콜렉션 뷰: " + String(indexPath.row))
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("하단 스크롤: \(behavior.currentIndex)")
        selectedOne = behavior.currentIndex
        collectionView.reloadData()
    }
}
