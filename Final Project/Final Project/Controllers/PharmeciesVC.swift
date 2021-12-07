//
//  PharmeciesVC.swift
//  Final Project
//
//  Created by Hassan Yahya on 03/05/1443 AH.
//

import UIKit

class Pharmacies: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	private var collectionView: UICollectionView?
	//==========================================================================
	
	override func viewDidLoad(){
		super.viewDidLoad()
		
		view.backgroundColor = UIColor (named: "myBackgroundColor2")
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 1
		layout.sectionInset = UIEdgeInsets(top: 20,left: 10,bottom: 100,right: 10)
		layout.itemSize = CGSize(width: 180, height: 220)
		
		collectionView = UICollectionView(frame: .zero,
										  collectionViewLayout: layout)
		
		guard let collectionView = collectionView else {
			return
		}
		
		collectionView.register(PharmacyCell.self, forCellWithReuseIdentifier: PharmacyCell.identifier)
		collectionView.dataSource = self
		collectionView.delegate = self
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
	}
	//==========================================================================
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->Int {
		
		return data_Pharmacy_str.count
	}
	//==========================================================================
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
		
		let list = data_Pharmacy_str[indexPath.row]
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyCell.identifier, for: indexPath) as! PharmacyCell
		
		cell.configure(label: "Custem\(indexPath.row)")
		
		cell.myImageView.image = list.image
		cell.name.text = list.name
		return cell
	}
	//==========================================================================
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let data1 = data_Pharmacy_str[indexPath.row]
		
		let VC1_CourtPageVC = ProductTV()
		VC1_CourtPageVC.imageCourtPage.image = data1.image
		VC1_CourtPageVC.nameCourtPage.text = data1.name
		VC1_CourtPageVC.productFromVC = data1
		
		navigationController?.pushViewController(VC1_CourtPageVC, animated: true)
	}
}
