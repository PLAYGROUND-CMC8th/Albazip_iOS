//
//  CommunityManagerSearchVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityManagerSearchVC: UIViewController{
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var middleView: UIView!
    var isNoData = true
    var searchWord = ""
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var noticeList : [CommunitySearchData]?
    // Datamanager
    lazy var dataManager: CommunityWorkerSearchDatamanager = CommunityWorkerSearchDatamanager()
    // Datamanager
    lazy var dataManager2: CommunityManagerNoticePinDatamanager = CommunityManagerNoticePinDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.addLeftPadding2()
        searchTextField.delegate = self
        setTableView()
        tableView.isHidden = true
        noticeLabel.isHidden = true
        middleView.isHidden = true
        searchTextField.attributedPlaceholder = NSAttributedString(string: "글 제목, 내용검색", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, NSAttributedString.Key.foregroundColor :   #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)])
      
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityManagerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerNoticeTableViewCell")
        tableView.register(UINib(nibName: "CommunitySearchNoDataTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunitySearchNoDataTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// 테이블뷰 extension
extension CommunityManagerSearchVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        if isNoData{
            return 1
        }else{
            if let data = noticeList{
                return data.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchNoDataTableViewCell") as? CommunitySearchNoDataTableViewCell {
                cell.selectionStyle = .none
                
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerNoticeTableViewCell") as? CommunityManagerNoticeTableViewCell {
                cell.selectionStyle = .none
                cell.delegate = self
                if let data = noticeList{
                    //cell.checkLabel.isHidden = true
                    cell.titleLabel.text = data[indexPath.row].title!
                    cell.subLabel.text = data[indexPath.row].registerDate!.insertDate
                    if data[indexPath.row].pin! == 0{
                        cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinInactive"), for: .normal)
                    }else{
                        cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinActive"), for: .normal)
                    }
                    cell.noticeId = data[indexPath.row].id!
                    
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoData{
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerNoticeDetailVC") as? CommunityManagerNoticeDetailVC else {return}
            nextVC.noticeId = noticeList![indexPath.row].id!
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension CommunityManagerSearchVC {
    func didSuccessCommunityWorkerSearch(result: CommunitySearchResponse) {
        
        print(result)
        noticeList = result.data
        print("noticeList: \(noticeList)")
        if  noticeList!.count != 0{
            isNoData = false
        }else{
            isNoData = true
        }
        
        tableView.reloadData()
        tableView.isHidden = false
        noticeLabel.isHidden = false
        middleView.isHidden = false
        dismissIndicator()
    }
    
    func failedToRequestCommunityWorkerSearch(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    
    //핀 성공
    func didSuccessCommunityManagerNoticePin(result: CommunityManagerNoticePinResponse) {
        print(result.message)
        dataManager.getCommunityWorkerSearch(searchWord: searchWord, vc: self)
    }
    //핀 5개 초과시
    func didSuccessCommunityManagerNoticePinOver(message: String) {
        
        dismissIndicator()
        presentBottomAlert(message: message)
    }
    //핀 실패
    func failedToRequestCommunityManagerNoticePin(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

// 핀 api
extension CommunityManagerSearchVC: CommunityManagerNoticeDelegate{
    func pinAPI(noticeId:Int) {
        print("핀 api 호출 \(noticeId)")
        showIndicator()
        dataManager2.getCommunityManagerNoticePin(noticeId: noticeId, vc: self)
    }
    
    
}


extension CommunityManagerSearchVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        if let text = searchTextField.text, text != ""{
            print(text)
            showIndicator()
            searchWord = text
            //api 호출
            dataManager.getCommunityWorkerSearch(searchWord: text, vc: self)
        }else{
            presentBottomAlert(message: "검색할 항목을 입력해주세요!")
        }
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        return true
    }
}
