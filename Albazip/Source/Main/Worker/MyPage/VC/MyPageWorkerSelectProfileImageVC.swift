//
//  MyPageWorkerSelectProfileImageVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/06.
//

import Foundation
import UIKit
class MyPageWorkerSelectProfileImageVC: UIViewController{
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var imageBorder1: UIImageView!
    @IBOutlet var imageBorder2: UIImageView!
    @IBOutlet var imageBorder3: UIImageView!
    @IBOutlet var imageBorder4: UIImageView!
    @IBOutlet var imageBorder5: UIImageView!
    @IBOutlet var cornerView: UIView!
    
    var imageUrl = ""
    var selectedImageIndex = 0
    var selectedImage = #imageLiteral(resourceName: "imgProfileW128Px2")
    var imageArray = [#imageLiteral(resourceName: "imgProfileW128Px1"), #imageLiteral(resourceName: "imgProfileW128Px2"), #imageLiteral(resourceName: "imgProfileW128Px3"), #imageLiteral(resourceName: "imgProfileW128Px4"), #imageLiteral(resourceName: "imgProfileW128Px5")]
    
    var imageDefaultUrl = ["https://albazip-bucket.s3.ap-northeast-2.amazonaws.com/default/w2.png","https://albazip-bucket.s3.ap-northeast-2.amazonaws.com/default/w1.png","https://albazip-bucket.s3.ap-northeast-2.amazonaws.com/default/w3.png","https://albazip-bucket.s3.ap-northeast-2.amazonaws.com/default/w5.png","https://albazip-bucket.s3.ap-northeast-2.amazonaws.com/default/w4.png"]
    var imageDefaultPost = ["w2", "w1", "w3", "w5", "w4"]
    var selectProfileImageDelegate : SelectProfileImageDelegate?
    lazy var dataManager: MyPageProfileImageDefaultDatamanager = MyPageProfileImageDefaultDatamanager()
    lazy var dataManager2: MyPageProfileImageUploadDatamanager = MyPageProfileImageUploadDatamanager()
    var isGally = false
    var isSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        //이미지뷰 동그랗게
        mainImage.layer.cornerRadius = mainImage.frame.width / 2
        mainImage.clipsToBounds = true
        
        // 이미지 첫 변경일때 디폴트로 젤 가운데꺼
        print(selectedImage.imageAsset)
        print(imageArray[2].imageAsset)
        
        // 1) 이미지 url null일 때
        if imageUrl == "" {
            print("이미지 url null")
            selectedImageIndex = 1
            changeImage(index: selectedImageIndex)
        }
        // 2) 사용자 지정 이미지이다
        else if imageUrl != imageDefaultUrl[0], imageUrl != imageDefaultUrl[1], imageUrl != imageDefaultUrl[2], imageUrl != imageDefaultUrl[3], imageUrl != imageDefaultUrl[4]{
            print("사용자 지정 이미지이다")
            mainImage.image = selectedImage
        }
        // 3) 앱 이미지 이다.
        
        //앱 이미지
        else{
            print("앱이미지이다")
            if(imageUrl == imageDefaultUrl[0]){
                selectedImageIndex = 0
            }else if(imageUrl == imageDefaultUrl[1]){
                selectedImageIndex = 1
            }else if(imageUrl == imageDefaultUrl[2]){
                print("3")
                selectedImageIndex = 2
            }else if(imageUrl == imageDefaultUrl[3]){
                selectedImageIndex = 3
            }else if(imageUrl == imageDefaultUrl[4]){
                selectedImageIndex = 4
            }
            changeImage(index: selectedImageIndex)
        }
    }
    func setUI(){
        imageBorder1.isHidden = true
        imageBorder2.isHidden = true
        imageBorder3.isHidden = true
        imageBorder4.isHidden = true
        imageBorder5.isHidden = true
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.navigationController?.isNavigationBarHidden = true
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
        
    }
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
        }
    func changeImage(index: Int){
        mainImage.image = imageArray[index]
        switch index{
        case 0:
            imageBorder1.isHidden = false
            
            break
        case 1:
            imageBorder2.isHidden = false
            break
        case 2:
            imageBorder3.isHidden = false
            break
        case 3:
            imageBorder4.isHidden = false
            break
        case 4:
            imageBorder5.isHidden = false
            break
        default:
            break
        }
    }
    @IBAction func btnImage1(_ sender: Any) {
        selectedImageIndex = 0
        setUI()
        changeImage(index: 0)
        isGally = false
        isSelected = true
    }
    
    @IBAction func btnImage2(_ sender: Any) {
        selectedImageIndex = 1
        setUI()
        changeImage(index: 1)
        isGally = false
        isSelected = true
    }
    
    @IBAction func btnImage3(_ sender: Any) {
        selectedImageIndex = 2
        setUI()
        changeImage(index: 2)
        isGally = false
        isSelected = true
    }
    
    @IBAction func btnImage4(_ sender: Any) {
        selectedImageIndex = 3
        setUI()
        changeImage(index: 3)
        isGally = false
        isSelected = true
    }
    
    @IBAction func btnImage5(_ sender: Any) {
        selectedImageIndex = 4
        setUI()
        changeImage(index: 4)
        isGally = false
        isSelected = true
    }
    
    
    @IBAction func btnGallary(_ sender: Any) {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController( )
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
                
        // 추가된 부분) 델리게이트 지정
        picker.delegate = self
                
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        selectProfileImageDelegate?.imageModalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: Any) {
        if !isSelected{
            print("api 호출 x")
            selectProfileImageDelegate?.imageModalDismiss()
            selectProfileImageDelegate?.changeImage()
            self.dismiss(animated: true, completion: nil)
        }else if isGally{
            print("이미지 업로드 api")
            showIndicator()
            dataManager2.postMyPageProfileImageUpload(imageData: mainImage.image, vc: self)
        }else{
            print("디폴트 이미지 api")
            showIndicator()
            dataManager.postMyPageProfileImageDefault(MyPageProfileImageDefaultRequest(defaultImage: imageDefaultPost[selectedImageIndex]),vc: self)
        }
        
    }
    
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        selectProfileImageDelegate?.imageModalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension MyPageWorkerSelectProfileImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // 이미지 피커 컨트롤러 창 닫기
    picker.dismiss(animated:false)
    /*
    self.dismiss(animated: false) { () in
      // 알림창 호출
      let alert = UIAlertController(title: "",
                                    message: "이미지 선택이 취소되었습니다",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .cancel))
      self.present(alert, animated: false)
    }*/
  }
  
  // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
        var newImage: UIImage? = nil // update 할 이미지
                
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        self.mainImage.image = newImage
        isGally = true
        isSelected = true
        // 이미지 피커 컨트롤러 창 닫기
        setUI()
        picker.dismiss(animated: false)
    }
}

extension MyPageWorkerSelectProfileImageVC {
    func didSuccessMyPageProfileImageDefault(result:  MyPageProfileImageDefaultResponse) {
        dismissIndicator()
        selectProfileImageDelegate?.imageModalDismiss()
        selectProfileImageDelegate?.changeImage()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedToRequestMyPageProfileImageDefault(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

extension MyPageWorkerSelectProfileImageVC {
    func didSuccessMyPageProfileImageUpload(result:  MyPageProfileImageDefaultResponse) {
        print(result)
        dismissIndicator()
        selectProfileImageDelegate?.imageModalDismiss()
        selectProfileImageDelegate?.changeImage()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedToRequestMyPageProfileImageUpload(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
