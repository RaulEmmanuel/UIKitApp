//
//  SignUpViewController.swift
//  UIKitApp
//
//  Created by Laura Anguiano on 15/09/22.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var lblEMail: PrimaryTextField!{
        didSet{
            self.lblEMail.delegate = self
        }
    }
    
    @IBOutlet weak var lblCName: PrimaryTextField!{
        didSet{
            self.lblCName.delegate = self
        }
    }
    
    @IBOutlet weak var lblSsap: PrimaryTextField!{
        didSet{
            self.lblSsap.delegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: - F U N C T I O N S
    @objc func dismissKeyboard() {
        view.endEditing(true)
        configureTextFields()
    }

    private func configureTextFields(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)

        NotificationCenter.default.addObserver(self, selector: #selector(changekeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changekeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changekeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        lblEMail.resignFirstResponder()
        lblCName.resignFirstResponder()
        lblSsap.resignFirstResponder()
    }

    @objc func changekeyboard(notification: Notification){
        let keyboardInfo = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        let keyboarDimensions = keyboardInfo?.cgRectValue
        let keyboardHeight = keyboarDimensions?.height

        switch notification.name.rawValue {
        case "UIKeyboardWillHideNotification":
            view.frame.origin.y = 0
        case "UIKeyboardWillShowNotification":
            if lblEMail.isFirstResponder { view.frame.origin.y = (-1 * keyboardHeight!) * 0.3 }
            if lblCName.isFirstResponder { view.frame.origin.y = (-1 * keyboardHeight!) * 0.5 }
            if lblSsap.isFirstResponder { view.frame.origin.y = (-1 * keyboardHeight!) * 0.7 }
        default: view.frame.origin.y = 0
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapSignUp(_ sender: Any) {
        if !self.validmail() {
            self.lblEMail.setupErrorStyle()
            return
        } else {
            self.lblEMail.setupViewStyle()
        }
    
        if !self.validFullName() {
            self.lblCName.setupErrorStyle()
            return
        } else {
            self.lblCName.setupViewStyle()
        }
        
        
        if !self.validPassword() {
            self.lblSsap.setupErrorStyle()
            return
        } else {
            self.lblSsap.setupViewStyle()
        }
        
        self.showHome()
        
    }
    
    private func validmail() -> Bool{
         return self.lblEMail.campo_vacio() ? false : true
     }
     
     private func validFullName() -> Bool{
         return  self.lblCName.campo_vacio() ? false : true
     }
     
     private func validPassword() -> Bool{
         return  self.lblSsap.campo_vacio() ? false : true
     }
    
    
    func showHome() {
        guard let name = self.lblCName.text else{ return }
        UserDefaults.standard.set(name, forKey: "name")
       
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "dashboardView") as? DashboardViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        
    }
}

// MARK: - Static Methods
extension SignUpViewController {
    static func getViewController() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {
            fatalError("ViewController must be of type SignUpViewController")
        }
        return signUpViewController
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }
}
