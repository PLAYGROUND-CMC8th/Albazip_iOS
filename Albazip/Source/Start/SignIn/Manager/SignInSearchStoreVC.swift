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
    @IBOutlet var baseView: UIView!
    
    //맵뷰
    var mapView: MTMapView?
    
    //선택된 컬렉션뷰
    var selectedOne = 0
    
    //스크롤 action
    let behavior = MSCollectionViewPeekingBehavior()
    
    // 위치 더미 데이터
    let locationXArray: Array<Double> = [127.09834963621634, 127.12725826084582, 127.07339478315626, 127.0748329498537, 127.07126628056506]
    let locationYArray: Array<Double> = [37.19639318015116,37.188159769329644, 37.20746987253404, 37.1945190595383, 37.20093314538069]
    let mainTitle: Array<String> = ["파리바게뜨 동탄역점","파리바게뜨 동탄금강점","파리바게뜨 동탄시범점","파리바게뜨 동탄나루마을점","파리바게뜨 동탄다은솔빛점"]
    let subTitle: Array<String> = ["경기 화성시 오산동 967-2429","경기 화성시 목동 산 34","경기 화성시 반송동 86-4","경기 화성시 반송동 218-1","경기 화성시 반송동 104-1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCollectionView()
        setMapView()
    }
    
    func setUI(){
        let attrString = NSMutableAttributedString(string: alertLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        alertLabel.attributedText = attrString
        searchTextField.addLeftPadding()
        cornerView.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        //리턴키 누르기 전까지 뷰 hide
        //cornerView.isHidden = true
        //baseView.isHidden = true
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
    
    func setMapView(){
        // 크기를 뷰 크기 만큼
        mapView = MTMapView(frame: baseView.bounds)
        
        mapView?.delegate = self
        
        mapView?.baseMapType = .standard
        
        // 위치 정보
        let pointGeo = MTMapPointGeo(latitude: locationYArray[0], longitude: locationXArray[0])
        let point = MTMapPoint(geoCoord: pointGeo)
        
        // 포인트를 맵의 센터로 사용
        mapView?.setMapCenter(point, animated: true)
        
        // 화면 설정
        mapView?.setZoomLevel(-1, animated: true)
        if let mapView = self.mapView {
            baseView.addSubview(mapView)
        }
        
        //마커 찍기
        let item = MTMapPOIItem()
        item.itemName = mainTitle[0]
        item.mapPoint = point
        
        item.markerType = .customImage
        item.customImage = #imageLiteral(resourceName: "icPinLocation")
            
        item.markerSelectedType = .customImage
        item.customSelectedImage = #imageLiteral(resourceName: "icPinLocation")
        mapView?.add(item)
    }
    
    func changeMapView(index:Int){
        let item1 = MTMapPOIItem()
        let pointGeo = MTMapPointGeo(latitude: locationYArray[index], longitude: locationXArray[index])
        let point = MTMapPoint(geoCoord: pointGeo)
        item1.itemName = mainTitle[index]
        item1.mapPoint = point
        item1.markerType = .customImage
        item1.customImage = #imageLiteral(resourceName: "icPinLocation")
        item1.markerSelectedType = .customImage
        item1.customSelectedImage = #imageLiteral(resourceName: "icPinLocation")
        mapView?.add(item1)
        
        if let mapView = mapView{
            // 포인트를 맵의 센터로 사용
            mapView.setMapCenter(point, animated: true)
            // 화면 설정
            mapView.setZoomLevel(-1, animated: true)
            
        }
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
            cell.titleLabel.text = mainTitle[indexPath.row]
            cell.subLabel.text = subTitle[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    //스크롤뷰
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        print("지도 뷰 변환: " + String(behavior.currentIndex))
        changeMapView(index: behavior.currentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("하단 콜렉션 뷰: " + String(indexPath.row))
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("하단 스크롤 뷰: \(behavior.currentIndex)")
        selectedOne = behavior.currentIndex
        collectionView.reloadData()
    }
}

extension SignInSearchStoreVC: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) 터치됨")
        }
    }
    // 오른쪽 이미지를 클릭했을때
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonRightSideOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) RightSide 터치됨")
        }
    }
    
    // 왼쪽 이미지를 클릭했을때
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonLeftSideOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) LeftSide 터치됨")
        }
    }
}
