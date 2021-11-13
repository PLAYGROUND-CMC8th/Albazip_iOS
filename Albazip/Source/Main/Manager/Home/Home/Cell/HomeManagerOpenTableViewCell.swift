//
//  HomeManagerOpenTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//
protocol HomeManagerOpenDeleagate: AnyObject {
    func goAddWorkPage()
    func goPublicWork()
    func goPrivateWork()
    func goTodayWorkerList()
}
import UIKit

class HomeManagerOpenTableViewCell: UITableViewCell {

    @IBOutlet var publicWorkView: UIView!
    @IBOutlet var privateWorkView: UIView!
    @IBOutlet var todayWorkerView: UIView!
    
    weak var delegate : HomeManagerOpenDeleagate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( publicWorkViewTapped))
        publicWorkView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(privateWorkViewTapped))
        privateWorkView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(todayWorkerViewTapped))
        todayWorkerView.addGestureRecognizer(tapGestureRecognizer3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddWork(_ sender: Any) {
        delegate?.goAddWorkPage()
    }
    @objc func publicWorkViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.goPublicWork()
       
        
    }
    @objc func privateWorkViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.goPrivateWork()
    }
    
    @objc func todayWorkerViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.goTodayWorkerList()
    }
    
}
