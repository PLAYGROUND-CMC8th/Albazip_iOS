//
//  CommunityManagerNoticeDetailImageVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/29.
//

import Foundation
class CommunityManagerNoticeDetailImageVC: UIViewController{
    var imageUrl = ""
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageUrl)
        imageView.kf.setImage(with: url)
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
