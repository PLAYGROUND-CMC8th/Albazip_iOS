//
//  StoreHourUnCompletedVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/04.
//

protocol StoreHourUnCompletedDelegate: AnyObject {
    func modalDismiss()
    func backToPage()
}
class StoreHourUnCompletedVC: UIViewController{
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cornerView: UIView!
    @IBOutlet var contentLabel: UILabel!
    
    weak var delegate: StoreHourUnCompletedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGesture()
    }
    func setUI(){
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let attrString = NSMutableAttributedString(string: contentLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .center
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        contentLabel.attributedText = attrString
    }
    func setGesture(){
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOk(_ sender: Any) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: {
            self.delegate?.backToPage()
        })
    }
    
    
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
}
