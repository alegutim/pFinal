//
//  textFieldController.swift
//  pFinal
//
//  Created by Alejandro  Gutierrez on 25/03/17.
//  Copyright © 2017 Alejandro  Gutierrez. All rights reserved.
//

import UIKit

class textFieldController:  UITextFieldDelegate{

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text!
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }

}
