//
//  FavroiteVC.swift
//  Final Project
//
//  Created by Hassan Yahya on 09/05/1443 AH.
//


import UIKit

class FavouriteVC : UIViewController , UITableViewDelegate, UITableViewDataSource{
	
	
	
	var aPlace: Array<FavArabic> = []
	
	var selectedIndex = -1
	
	
	lazy  var placeTV: UITableView = {
		let tableV = UITableView()
		tableV.translatesAutoresizingMaskIntoConstraints = false
		tableV.delegate = self
		tableV.dataSource = self
		tableV.register(FavouriteCell.self, forCellReuseIdentifier: "Fav")
		tableV.isHidden = false
		tableV.backgroundColor = .white
		
		return tableV
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//        setGradientBackground()
		
		
		view.backgroundColor = UIColor(named: "BackG")
		
		//		self.title = "My List"
		view.reloadInputViews()
		
		view.addSubview(placeTV)
		NSLayoutConstraint.activate([
			placeTV.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			placeTV.heightAnchor.constraint(equalToConstant: 100),
			placeTV.widthAnchor.constraint(equalToConstant: -200),
			placeTV.leftAnchor.constraint(equalTo: view.leftAnchor),
			placeTV.rightAnchor.constraint(equalTo: view.rightAnchor),
			placeTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		
		
		FavoriteServiceVisitor.shared.listenToFavoriteBook { favPlace in
			self.aPlace = favPlace
			self.placeTV.reloadData()
			
		}
		
		
		
		//  var image = UIImage(systemName: "like2")
		//        let image = UIImage(systemName: "checkmark.seal.fill")
		//                           tabBarItem = .init(title: NSLocalizedString("My List", comment: ""), image: image, selectedImage: image)
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return aPlace.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Fav", for: indexPath) as! FavouriteCell
		
		let a = aPlace[indexPath.row]
		
		cell.nameLabel2.text = a.name
		cell.placeImage2.image = UIImage(named: a.image)
		cell.backgroundColor = .white
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == selectedIndex {
			return 354
		}else {
			return 190
		}
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		
		let cell = aPlace[indexPath.row]
		let alertcontroller = UIAlertController(title: "Delete Place"
												, message: "Are you sure?"
												, preferredStyle: UIAlertController.Style.alert
		)
		
		alertcontroller.addAction(
			UIAlertAction(title: "cancel",
						  style: UIAlertAction.Style.default,
						  handler: { Action in print("...")
						  })
			
		)
		
		alertcontroller.addAction(
			UIAlertAction(title: "Delete",
						  style: UIAlertAction.Style.destructive,
						  handler: { [self] Action in
							  if editingStyle == .delete {
								  FavoriteServiceVisitor.shared.deleteStudent(studentId: aPlace[indexPath.row].id)
								  
								  //					self.APlace.remove(at: indexPath.row)
								  //					self.placeTV.deleteRows(at: [indexPath], with: .fade)
							  }
							  //				self.placeTV.reloadData()
						  })
			
		)
		
		self.present(alertcontroller, animated: true, completion: nil)
		
	}
}
