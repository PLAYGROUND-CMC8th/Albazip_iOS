//
//  SettingNoticeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
class SettingNoticeVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "SettingNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "SettingNoticeTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension SettingNoticeVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingNoticeTableViewCell") as? SettingNoticeTableViewCell {
                cell.selectionStyle = .none
                
                print(indexPath.row)
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.selectionStyle = .none
                cell.titleLabel.text = "작성된 글이 없어요."
                print(indexPath.row)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.row == 0{
            return 103
        }else{
            return 326
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
