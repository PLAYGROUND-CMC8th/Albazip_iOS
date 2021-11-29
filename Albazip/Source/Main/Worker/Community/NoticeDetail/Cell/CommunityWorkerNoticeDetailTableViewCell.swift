//
//  CommunityWorkerNoticeDetailTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import UIKit

protocol CommunityWorkerNoticeDetailDelegate {
    func showImagePage(index:Int)
}

class CommunityWorkerNoticeDetailTableViewCell: UITableViewCell {
    var cellCount = 3
    
    var delegate: CommunityWorkerNoticeDetailDelegate?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var completePeopleView: UIView!
    @IBOutlet var completePeopleViewHeight: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var personCount: UILabel!
    @IBOutlet var personView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    
    @IBOutlet var height1: NSLayoutConstraint!
    @IBOutlet var height2: NSLayoutConstraint!
    var comWorker: [CommunityManagerNoticeConfirmer]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completePeopleView.isHidden = true
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(tapGestureRecognizer)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * cellCount)
        //이미지뷰 동그랗게
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(image1Tapped))
        image1.addGestureRecognizer(tapGestureRecognizer2)
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(image2Tapped))
        image2.addGestureRecognizer(tapGestureRecognizer3)
        //image1.isUserInteractionEnable(true)
        //image2.isUserInteractionEnable(true)
        
        
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
    }
    
    //이미지 상세보기 페이지로
    @objc func image1Tapped(sender: UITapGestureRecognizer) {
        print("이미지 1")
        delegate?.showImagePage(index: 0)
    }
    
    //이미지 상세보기
    @objc func image2Tapped(sender: UITapGestureRecognizer) {
        print("이미지 2")
        delegate?.showImagePage(index: 1)
    }
    
    
    //데이터 가져올 함수
    func setCell(data: [CommunityManagerNoticeConfirmer])  {
        comWorker = data
        personCount.text = String(data.count)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * data.count)
        self.tableView.reloadData()
    }
}
extension CommunityWorkerNoticeDetailTableViewCell: UITableViewDataSource,UITableViewDelegate {
    
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
                    //cell.countLabel.text = String(data[indexPath.row].count!)
                    let url = URL(string: data[indexPath.row].writerImage ?? "")
                    cell.profileImage.kf.setImage(with: url)
                    //let result = data[indexPath.row].worker!.components(separatedBy: " ")
                    cell.countLabel.isHidden = true
                    cell.nameLabel.text = data[indexPath.row].writerName!
                    cell.positionLabel.text = data[indexPath.row].writerTitle!
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
