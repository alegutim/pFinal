//
//  ViewControllerRegistro.swift
//  pFinal
//
//  Created by Alejandro  Gutierrez on 25/03/17.
//  Copyright © 2017 Alejandro  Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerRegistro: UIViewController , UITextFieldDelegate{
    
    var scrollGestureRecognizer: UITapGestureRecognizer!
    var telefono: String = ""
    
    @IBOutlet weak var txtPass1: UITextField!
    @IBOutlet weak var txtPass2: UITextField!
    @IBOutlet weak var txtPass3: UITextField!
    @IBOutlet weak var txtPass4: UITextField!
    @IBOutlet weak var txtCpass1: UITextField!
    @IBOutlet weak var txtCpass2: UITextField!
    @IBOutlet weak var txtCpass3: UITextField!
    @IBOutlet weak var txtCpass4: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailConfirm: UITextField!
    
    
    @IBAction func btnFinalizar(sender: AnyObject) {
        let password : String = txtPass1.text! + txtPass2.text! + txtPass3.text! + txtPass4.text!
        let passwordConfirm = txtCpass1.text! + txtCpass2.text! + txtCpass3.text! + txtCpass4.text!
        // 1. Validar cuadro de texto
        var elMsg = ""
        if password.characters.count == 0 {
            elMsg = "Debes de ingresar una contraseña"
        }
        if self.txtEmail.text?.characters.count == 0 && elMsg=="" {
            elMsg = "Debes de ingresar un correo electronico."
        }
        if password != passwordConfirm && elMsg=="" {
            elMsg = "Las contraseñas no coinciden."
        }
        
        if !isValidEmail(self.txtEmail.text!)  && elMsg=="" {
            elMsg = "El correo electronico no es valido."
        }
        
        if self.txtEmail.text != self.txtEmailConfirm.text && elMsg=="" {
            elMsg = "El correo electronico no coincide."
        }
        // 2. Si no e valido, presentar mensaje de error
        if elMsg != "" {
            let ac = UIAlertController(title: "Error", message: elMsg, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
        } else {
            // 3. Si todo esta correcto, guardamos en la base de datos y regresamos a la pantalla principal.
            if (telefono.characters.count==10){
                let entityInfo = NSEntityDescription.entityForName("USUARIOS", inManagedObjectContext:DBManager.instance.managedObjectContext!)
                let nuevoUsuario = NSManagedObject.init(entity: entityInfo!, insertIntoManagedObjectContext: DBManager.instance.managedObjectContext!) as! USUARIOS
                nuevoUsuario.telefono = self.telefono
                nuevoUsuario.contrasena = password
                nuevoUsuario.correo = self.txtEmail.text!

                do {
                    try DBManager.instance.managedObjectContext!.save()
                    performSegueWithIdentifier("registered", sender: self)
                    //self.navigationController?.popViewControllerAnimated(true)
                } catch {
                    print ("Error al salvar la BD... what's up?")
                }
            
            }
            //

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        txtPass1.delegate = self
        txtPass2.delegate = self
        txtPass3.delegate = self
        txtPass4.delegate = self
        txtCpass1.delegate = self
        txtCpass2.delegate = self
        txtCpass3.delegate = self
        txtCpass4.delegate = self
        txtPass1.becomeFirstResponder()
        
        // Keyboard notifications
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        scrollGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyBoard")
        scrollView.addGestureRecognizer(scrollGestureRecognizer)

    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
    }
    
    func keyboardWillHide(notification: NSNotification) {

    }
    
    func hideKeyBoard(){
        // Hide the keyboard
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if textField.tag == txtPass1.tag || textField.tag == txtPass2.tag  ||  textField.tag == txtPass3.tag  || textField.tag == txtPass4.tag || textField.tag == txtCpass1.tag || textField.tag == txtCpass2.tag || textField.tag == txtCpass3.tag || textField.tag == txtCpass4.tag{
            let maxLength = 1
            let currentString: NSString = textField.text!
            let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
            }
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    

}
