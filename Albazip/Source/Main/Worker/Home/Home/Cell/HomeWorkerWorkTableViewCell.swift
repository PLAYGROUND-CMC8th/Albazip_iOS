//
//  HomeWorkerWorkTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//
protocol HomeWorkerWorkDeleagate: AnyObject {
    func goPublicWork()
    func goPrivateWork()
}
import UIKit

class HomeWorkerWorkTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var positionImage: UIImageView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var publicView: UIView!
    @IBOutlet var privateView: UIView!
    @IBOutlet var publicBar: UIProgressView!
    @IBOutlet var privateBar: UIProgressView!
    @IBOutlet var totalPublicCountLabel: UILabel!
    @IBOutlet var clearPublicCountLabel: UILabel!
    @IBOutlet var totalPrivateCountLabel: UILabel!
    @IBOutlet var clearPrivateCountLabel: UILabel!
    @IBOutlet var honeyImage: UIImageView!
    weak var delegate : HomeWorkerWorkDeleagate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( publicViewTapped))
        publicView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(privateViewTapped))
        privateView.addGestureRecognizer(tapGestureRecognizer2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func publicViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.goPublicWork()
       
        
    }
    @objc func privateViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.goPrivateWork()
    }
}
