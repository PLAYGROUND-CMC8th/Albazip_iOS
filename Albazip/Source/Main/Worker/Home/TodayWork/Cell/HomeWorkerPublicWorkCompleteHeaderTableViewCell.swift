//
//  HomeWorkerPublicWorkCompleteHeaderTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

import UIKit

class HomeWorkerPublicWorkCompleteHeaderTableViewCell: UITableViewCell {
    var comWorker: [HomeWorkerComWorkerList]?
    @IBOutlet var completePeopleViewHeight: NSLayoutConstraint!
    @IBOutlet var personView: UIView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var completePeopleView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var peopleCountLabel: UILabel!
    var cellCount = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completePeopleView.isHidden = true
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(tapGestureRecognizer)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * cellCount)
        
        //그림자 주기
        completePeopleView.layer.shadowOpacity = 0.1

        completePeopleView.layer.shadowOffset = CGSize(width: 3, height: 3)

        completePeopleView.layer.shadowRadius = 10

        completePeopleView.layer.masksToBounds = false
        setTableView()
    }
    func setTableView(){
        
        tableView.register(UINib(nibName: "HomeWorkerCompletePeopleTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerCompletePeopleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func personViewTapped(sender: UITapGestureRecognizer) {
        print("몇명일까요")
        completePeopleView.isHidden.toggle()
        if completePeopleView.isHidden{
            personView.backgroundColor = #colorLiteral(red: 0.9567686915, green: 0.9569286704, blue: 0.9567475915, alpha: 1)
        }else{
            personView.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
        }
    }
    //데이터 가져올 함수
    func setCell(data: [HomeWorkerComWorkerList])  {
        comWorker = data
        peopleCountLabel.text = String(data.count)
        if data.count < 3{
            completePeopleViewHeight.constant = CGFloat(45 + 36 * data.count)
        }else{ // 3이상이면
            completePeopleViewHeight.constant = CGFloat(45 + 36 * 3)
        }
        self.tableView.reloadData()
    }

}
extension HomeWorkerPublicWorkCompleteHeaderTableViewCell: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data = comWorker{
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerCompletePeopleTableViewCell") as? HomeWorkerCompletePeopleTableViewCell {
                cell.selectionStyle = .none
                if let data = comWorker{
                    cell.countLabel.text = String(data[indexPath.row].count!)
                    let url = URL(string: data[indexPath.row].image ?? "")
                    cell.profileImage.kf.setImage(with: url)
                    let result = data[indexPath.row].worker!.components(separatedBy: " ")
                    
                    cell.nameLabel.text = result[1]
                    if result[0] == "사장님"{
                        cell.positionLabel.textColor = #colorLiteral(red: 0.9988076091, green: 0.5284297466, blue: 0, alpha: 1)
                    }else{
                        cell.positionLabel.textColor = #colorLiteral(red: 0.997828424, green: 0.6929262877, blue: 0, alpha: 1)
                    }
                    cell.positionLabel.text = result[0]
                }
                print(indexPath.row)
                return cell
            }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if let data = comWorker{
            return 36
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
