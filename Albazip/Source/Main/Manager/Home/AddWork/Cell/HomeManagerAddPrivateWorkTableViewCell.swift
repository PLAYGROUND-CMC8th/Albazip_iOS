//
//  HomeManagerAddPrivateWorkTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/14.
//

import UIKit
//MARK: Protocol

protocol HomeManagerAddPrivateWorkTableViewCellDelegate: AnyObject {
    func changePostition(index: Int)
}
class HomeManagerAddPrivateWorkTableViewCell: UITableViewCell {
    // 프로토콜 변수
    
    weak var delegate: HomeManagerAddPrivateWorkTableViewCellDelegate?
    @IBOutlet var collectionView: UICollectionView!
    let horizonInset: CGFloat = 20
    let lineSpacing: CGFloat = 10
    var selectedItem = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell() {
        let collectionViewNib = UINib(nibName: "HomeManagerAddPrivateWorkCollectionViewCell", bundle: nil)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "HomeManagerAddPrivateWorkCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension HomeManagerAddPrivateWorkTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeManagerAddPrivateWorkCollectionViewCell", for: indexPath) as? HomeManagerAddPrivateWorkCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.index = indexPath.row
        if selectedItem == indexPath.row{
            cell.view.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            cell.view.borderColor =  #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
            cell.positionLabel.textColor = #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
        }else{
            cell.view.backgroundColor = .none
            cell.view.borderColor = #colorLiteral(red: 0.9371626377, green: 0.9373196363, blue: 0.9414473176, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1)
            cell.positionLabel.textColor = #colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1)
        }
        return cell
    }
}
extension HomeManagerAddPrivateWorkTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        let cellWidth = collectionView.frame.width / 4
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: horizonInset, bottom: 0, right: horizonInset)
    }
}

extension HomeManagerAddPrivateWorkTableViewCell: HomeManagerAddPrivateWorkCollectionViewCellDelegate{
    func positionCellClicked(index: Int) {
        selectedItem = index
        delegate?.changePostition(index: index)
        collectionView.reloadData()
    }
    
    
}
