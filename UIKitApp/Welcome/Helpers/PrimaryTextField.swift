//
//  PrimaryTextField.swift
//  UIKitApp
//
//  Created by Laura Anguiano on 15/09/22.
//

import UIKit

@IBDesignable final class PrimaryTextField: UITextField {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewStyle()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupViewStyle()
    }
}

// MARK: - Private methods
extension PrimaryTextField {
    func setupViewStyle() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = CustomColor.border.value.cgColor
    }
    
    public func setupErrorStyle() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    
    public func correo_valido() -> Bool {
        let texto = self.text
        if texto != String()
        {
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: texto)
        }
        else
        {
            return false
        }
    }
    
    public func campo_vacio() -> Bool {
        let texto = self.text
        if texto == String(){   return true }
        else{   return false    }
    }
    
}
