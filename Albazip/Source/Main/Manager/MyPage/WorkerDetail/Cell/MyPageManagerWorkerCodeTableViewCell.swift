//
//  MyPageManagerWorkerCodeTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

protocol MyPageManagerWorkerCodeDelegate {
    func copyAlert()
}
import UIKit

class MyPageManagerWorkerCodeTableViewCell: UITableViewCell {

    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var codeView: UIView!
    var delegate : MyPageManagerWorkerCodeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        codeView.asCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCopy(_ sender: Any) {
        UIPasteboard.general.string = codeLabel.text
        delegate?.copyAlert()
        
    }
    
}
