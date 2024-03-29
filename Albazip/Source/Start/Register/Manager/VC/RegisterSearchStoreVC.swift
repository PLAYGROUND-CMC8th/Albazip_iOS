//
//  RegisterSearchStoreVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class RegisterSearchStoreVC: UIViewController{
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var baseView: UIView!
    @IBOutlet var noSearchView: UIView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnDirectRegister: UIButton!
    
    
    //맵뷰
    var mapView: MTMapView?
    
    //선택된 컬렉션뷰
    var selectedOne = 0
    
    //스크롤 action
    let behavior = MSCollectionViewPeekingBehavior()
    
    // Datamanager
    lazy var dataManager: RegisterSearchStoreDataManager = RegisterSearchStoreDataManager()
    
    var searchData: [RegisterSearchDocuments]?
    
    // 지도 검색이 처음인지
    var isFirstSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firebase.Log.signupSearchStoreBefore.event()
        
        setUI()
        setTextField()
        setCollectionView()
        cornerView.isHidden = true
        noSearchView.isHidden = true
        // 맵뷰 감추기
        mapView?.isHidden = true
        //setMapView()
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
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "매장명+지점 검색", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
    }
    
    func setTextField()  {
        searchTextField.delegate = self
        searchTextField.addLeftPadding()
        self.dismissKeyboardWhenTappedAround()
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
        
        
        if let data = searchData, searchData?.count != 0{
            if(isFirstSearch){
                isFirstSearch = false
            }
            cornerView.isHidden = false
            btnNext.isHidden = false
            collectionView.isHidden = false
            noSearchView.isHidden = true
            // 위치 정보
            let pointGeo = MTMapPointGeo(latitude: Double(data[0].y ?? "0")!, longitude: Double(data[0].x ?? "0")!)
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
            item.itemName = data[0].place_name
            item.mapPoint = point
                
            item.markerType = .customImage
            item.customImage = #imageLiteral(resourceName: "icPinLocation")
                    
            item.markerSelectedType = .customImage
            item.customSelectedImage = #imageLiteral(resourceName: "icPinLocation")
            mapView?.add(item)
            
        }else{
                print("검색 결과 없음")
                cornerView.isHidden = false
                btnNext.isHidden = true
                collectionView.isHidden = true
                noSearchView.isHidden = false
            if(isFirstSearch){
                // 위치 정보
                let pointGeo = MTMapPointGeo(latitude: 0.0, longitude: 0.0)
                let point = MTMapPoint(geoCoord: pointGeo)
                    
                // 포인트를 맵의 센터로 사용
                mapView?.setMapCenter(point, animated: true)
                    
                // 화면 설정
                mapView?.setZoomLevel(-1, animated: true)
                if let mapView = self.mapView {
                    baseView.addSubview(mapView)
                }
            }
        }
    }
    
    func changeMapView(index:Int){
        
        if let data = searchData{
            let item1 = MTMapPOIItem()
            let pointGeo = MTMapPointGeo(latitude: Double(data[index].y!)!, longitude: Double(data[index].x!)!)
            let point = MTMapPoint(geoCoord: pointGeo)
            item1.itemName = data[index].place_name
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
    
    func searchLocation(text:String)  {
        dataManager.searchStore(vc: self, searchText: text)
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDirectRegister(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterStoreInfoVC") as? RegisterStoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        Firebase.Log.signupSearchStoreAfter.event()
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterStoreInfoVC") as? RegisterStoreInfoVC else {return}
        nextVC.storeName = searchData![selectedOne].place_name!
        nextVC.storeLocation = searchData![selectedOne].address_name!
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension RegisterSearchStoreVC {
    func didSuccessSearchStore(_ result: RegisterSearchStoreResponse) {
        //self.presentAlert(title: "장바구니 담기 성공!", message: result.message)
        //print("결제 정보 가져오기 성공!\(result.message!)")
        print(result.documents)
        searchData = result.documents
        //tableView.reloadData()
        
        setMapView()
        mapView?.isHidden = false
        collectionView.reloadData()
        //cornerView.isHidden = false
        
    }
    
    func failedToSearchStore(message: String) {
        self.presentAlert(title: message)
    }
}


//MARK: 텍스트 델리게이트
extension RegisterSearchStoreVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        textField.borderColor = .mainYellow
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.borderColor = .lightGray
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        if let text = textField.text{
            searchLocation(text: text)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}

//MARK: 콜렉션뷰 델리게이트
extension RegisterSearchStoreVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = searchData{
            return data.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell {
            if let data = searchData{
                if(indexPath.row == selectedOne){
                    cell.searchView.backgroundColor = .semiYellow
                    cell.searchView.borderColor = .mainYellow
                    cell.searchView.borderWidth = 2
                }else{
                    cell.searchView.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
                    cell.searchView.borderWidth = 1
                    cell.searchView.borderColor = #colorLiteral(red: 0.8077629209, green: 0.8078994155, blue: 0.8077449799, alpha: 1)
                }
                cell.titleLabel.text = data[indexPath.row].place_name
                cell.subLabel.text = data[indexPath.row].address_name
            }
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

//MARK: 맵뷰 델리게이트
extension RegisterSearchStoreVC: MTMapViewDelegate {
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
