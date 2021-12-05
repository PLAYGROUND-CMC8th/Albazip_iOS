//
//  CommunityWorkerSearchVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerSearchVC: UIViewController{
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var middleView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    var isNoData = true
    var noticeList : [CommunitySearchData]?
    // Datamanager
    lazy var dataManager: CommunityWorkerSearchDatamanager = CommunityWorkerSearchDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        tableView.isHidden = true
        noticeLabel.isHidden = true
        middleView.isHidden = true
        searchTextField.attributedPlaceholder = NSAttributedString(string: "글 제목, 내용검색", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, NSAttributedString.Key.foregroundColor :   #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)])
    }
    func setUI()  {
        searchTextField.addLeftPadding2()
        searchTextField.delegate = self
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityWorkerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityWorkerNoticeTableViewCell")
        tableView.register(UINib(nibName: "CommunitySearchNoDataTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunitySearchNoDataTableViewCell")
        //CommunitySearchNoDataTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
    }
}
// 테이블뷰 extension
extension CommunityWorkerSearchVC: UITableViewDataSource, UITableViewDelegate{
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityWorkerNoticeTableViewCell") as? CommunityWorkerNoticeTableViewCell {
                cell.selectionStyle = .none
                if let data = noticeList{
                    //cell.checkLabel.isHidden = true
                    if data[indexPath.row].confirm! == 0{
                        cell.checkLabel.text = "미확인"
                        cell.checkLabel.textColor = #colorLiteral(red: 0.9833402038, green: 0.2258323133, blue: 0, alpha: 1)
                        cell.checkLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8983411193, blue: 0.8958156705, alpha: 1)
                        cell.noticeView.backgroundColor =  #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
                        cell.noticeView.borderColor =  #colorLiteral(red: 0.9983271956, green: 0.9391896129, blue: 0.7384549379, alpha: 1)
                    }else{
                        cell.checkLabel.text = "확인"
                        cell.checkLabel.textColor = #colorLiteral(red: 0.1636831164, green: 0.7599473596, blue: 0.3486425281, alpha: 1)
                        cell.checkLabel.backgroundColor = #colorLiteral(red: 0.8957179189, green: 0.9912716746, blue: 0.9204327464, alpha: 1)
                        cell.noticeView.backgroundColor =  .none
                        cell.noticeView.borderColor =  #colorLiteral(red: 0.9293201566, green: 0.9294758439, blue: 0.9292996526, alpha: 1)
                    }
                    cell.titleLabel.text = data[indexPath.row].title!
                    cell.subLabel.text = data[indexPath.row].registerDate!.insertDate
                    if data[indexPath.row].pin! == 0{
                        cell.pinImage.isHidden = true
                    }else{
                        cell.pinImage.isHidden = false
                    }
                    
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoData{
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityWorkerNoticeDetailVC") as? CommunityWorkerNoticeDetailVC else {return}
            nextVC.noticeId = noticeList![indexPath.row].id!
            nextVC.confirm = noticeList![indexPath.row].confirm!
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityWorkerSearchVC {
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
}
extension CommunityWorkerSearchVC: UITextFieldDelegate{
    
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
