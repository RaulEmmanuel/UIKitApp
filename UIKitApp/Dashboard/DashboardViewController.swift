//
//  DashboardViewController.swift
//  UIKitApp
//
//  Created by 1029186 on 23/09/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var nameUser: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nameData = UserDefaults.standard.string(forKey: "name") else { return }
        nameUser.text = "Welcome, \(nameData)"
    }
}
