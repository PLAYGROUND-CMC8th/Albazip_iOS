//
//  HomeManagerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerVC: BaseViewController{
    
    var isOpen = true
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeManagerMainTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerMainTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerOpenTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerCommunityTableViewCell")
    }
    func setUI(){
        // 배경 색, 테이블 뷰 색 변경해줘야해서
        if isOpen{
            tableView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }else{
            tableView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
        }
    }
}
// 테이블뷰 extension
extension HomeManagerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if isOpen{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerOpenTableViewCell") as? HomeManagerOpenTableViewCell {
                    cell.selectionStyle = .none
                    //cell.bannerCellDelegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerMainTableViewCell") as? HomeManagerMainTableViewCell {
                    cell.selectionStyle = .none
                    //cell.bannerCellDelegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    return cell
                }
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerCommunityTableViewCell") as? HomeManagerCommunityTableViewCell {
                //cell.eventCellDelegate = self
                //cell.setCell(event: eventArray, eventText: eventTextArray)
                cell.selectionStyle = .none
                return cell
            }
 
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 480
        case 1:
            return 242
       
        default:
            return 0
        }
    }
}
