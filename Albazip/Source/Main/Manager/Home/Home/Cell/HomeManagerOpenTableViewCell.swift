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
    func goAddPublicWork()
}
import UIKit

class HomeManagerOpenTableViewCell: UITableViewCell {

    @IBOutlet var publicWorkView: UIView!
    @IBOutlet var privateWorkView: UIView!
    @IBOutlet var todayWorkerView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var clearPublicCountLabel: UILabel!
    @IBOutlet var totalPublicCountLabel: UILabel!
    @IBOutlet var publicBar: UIProgressView!
    @IBOutlet var privateBar: UIProgressView!
    @IBOutlet var totalPrivateCountLabel: UILabel!
    @IBOutlet var clearPrivateCountLabel: UILabel!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    //
    @IBOutlet var firstView1: UIView!
    @IBOutlet var firstView2: UIView!
    @IBOutlet var firstView3: UIView!
    @IBOutlet var firstName1: UILabel!
    @IBOutlet var firstName2: UILabel!
    //
    @IBOutlet var secondView1: UIView!
    @IBOutlet var secondView2: UIView!
    @IBOutlet var secondView3: UIView!
    @IBOutlet var secondName1: UILabel!
    @IBOutlet var secondName2: UILabel!
    //
    @IBOutlet var thirdView1: UIView!
    @IBOutlet var thirdView2: UIView!
    @IBOutlet var thirdView3: UIView!
    @IBOutlet var thirdName1: UILabel!
    @IBOutlet var thirdName2: UILabel!
    
    @IBOutlet var firstStack: UIStackView!
    @IBOutlet var secondStack: UIStackView!
    @IBOutlet var thirdStack: UIStackView!
    
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
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUI()  {
        firstView1.asCircle()
        firstView2.asCircle()
        firstView3.asCircle()
        secondView1.asCircle()
        secondView2.asCircle()
        secondView3.asCircle()
        thirdView1.asCircle()
        thirdView2.asCircle()
        thirdView3.asCircle()
    }
    @IBAction func btnAddWork(_ sender: Any) {
        delegate?.goAddPublicWork()
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
