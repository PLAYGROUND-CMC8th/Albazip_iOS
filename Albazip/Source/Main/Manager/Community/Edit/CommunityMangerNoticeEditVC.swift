//
//  CommunityMangerNoticeEditVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class CommunityMangerNoticeEditVC:UIViewController{
    var titleText = ""
    var contentText = ""
    var noticeId = -1
    var imageArray = [UIImage]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnNext: UIButton!
    // Datamanager
    lazy var dataManager: CommunityManagerWriteDatamanager = CommunityManagerWriteDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageArray)
        setTableView()
        self.dismissKeyboardWhenTappedAround()
    }
    @IBAction func btnEdit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        if contentText.count >= 20{
            showIndicator()
            dataManager.postCommunityManagerWriteEdit(noticeId: noticeId, title: titleText, content: contentText, pin: 0, imageData: imageArray, vc: self)
        }else{
            presentBottomAlert(message: "공지 내용을 20자 이상 입력해주세요!")
        }
    }
    func setTableView(){
        
        tableView.register(UINib(nibName: "CommunityManagerWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerWriteTableViewCell")
        tableView.register(UINib(nibName: "CommunityManagerPhotoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerPhotoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func checkBtn(){
        if titleText != "", contentText != ""{
            btnNext.isEnabled = true
            btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.setTitleColor(#colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1), for: .normal)
        }
    }
}

// 테이블뷰 extension
extension CommunityMangerNoticeEditVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerWriteTableViewCell") as? CommunityManagerWriteTableViewCell {
                cell.titleTextField.text = titleText
                cell.subTextField.text = contentText
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerPhotoTableViewCell") as? CommunityManagerPhotoTableViewCell {
                cell.selectionStyle = .none
                cell.delegate = self
                if imageArray.count == 1{
                    cell.Btndelete1.isHidden = false
                    cell.image1.isHidden = false
                    cell.Btndelete2.isHidden = true
                    cell.image2.isHidden = true
                    cell.image1.image = imageArray[0]
                }else if imageArray.count == 2{
                    cell.Btndelete1.isHidden = false
                    cell.image1.isHidden = false
                    cell.image1.image = imageArray[0]
                    cell.Btndelete2.isHidden = false
                    cell.image2.isHidden = false
                    cell.image2.image = imageArray[1]
                }else{
                    cell.Btndelete1.isHidden = true
                    cell.image1.isHidden = true
                    cell.Btndelete2.isHidden = true
                    cell.image2.isHidden = true
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 375
        }else{
            return 176
        }
        //return tableView.estimatedRowHeight
    }
}
extension CommunityMangerNoticeEditVC: CommunityManagerWriteDelegate, CommunityManagerPhotoDelegate{
    func deleteImage1() {
        //
        imageArray.remove(at: 0)
        tableView.reloadData()
    }
    
    func deleteImage2() {
        //
        imageArray.remove(at: 1)
        tableView.reloadData()
    }
    
    func selectPicture() {
        if imageArray.count == 0{
            pickImage()
        }else if imageArray.count == 1{
            pickImage()
        }else{
            presentBottomAlert(message: "이미지는 최대 두장만 선택 가능합니다.")
        }
        
    }
    
    func setTitleTextField(text: String) {
        titleText = text
        print(titleText)
        checkBtn()
    }
    
    func setSubTextField(text: String) {
        contentText = text
        print(contentText)
        checkBtn()
    }
    
    func pickImage(){
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController( )
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
                
        // 추가된 부분) 델리게이트 지정
        picker.delegate = self
                
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
    }
}
// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension CommunityMangerNoticeEditVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
       
        imageArray.append(newImage!)
        
        tableView.reloadData()
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false)
    }
}

extension CommunityMangerNoticeEditVC{
    func didSuccessCommunityManagerNoticeEdit(result: CommunityManagerWriteResponse){
        print(result)
        dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
    func failedToRequestCommunityManagerNoticeEdit(message: String){
        dismissIndicator()
        presentAlert(title: message)
    }
}

