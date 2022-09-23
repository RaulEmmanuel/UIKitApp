//
//  DashboardViewController.swift
//  UIKitApp
//
//  Created by 1029186 on 23/09/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nameData = UserDefaults.standard.string(forKey: "name") else { return }
        nameUser.text = "Welcome, \(nameData)"
        collectionView.dataSource = self
    }
}

extension DashboardViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath)
    }
}
