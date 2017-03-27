//
//  ViewController.swift
//  pFinal
//
//  Created by Alejandro  Gutierrez on 25/03/17.
//  Copyright © 2017 Alejandro  Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var txtNumero: UITextField!
    var telefono = "0000000000"
    var losUsuarios:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNumero.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext(sender: AnyObject) {

        // 1. Validar cuadro de texto
        var elMsg = ""
        if self.txtNumero.text?.characters.count == 0 {
            elMsg = "Debes de ingresar el numero telefonico"
        }
        if self.txtNumero.text?.characters.count != 10 && elMsg=="" {
            elMsg = "Debes de ingresar un numero valido."
        }
            // 2. Si no e valido, presentar mensaje de error
        if elMsg != "" {
            let ac = UIAlertController(title: "Error", message: elMsg, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
        } else {
            telefono = txtNumero.text!
            // 3. Si todo esta correcto, buscar el telefono en la base de datos.
            self.losUsuarios = DBManager.instance.encuentraUsuario("USUARIOS", filtradosPor:
                NSPredicate(format: "telefono=%@", self.telefono))
            if self.losUsuarios?.count==1 {
                performSegueWithIdentifier("registrado", sender: self)
            } else {
                performSegueWithIdentifier("noRegistrado", sender: self)
            }
        }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "noRegistrado"  {
            let destino = segue.destinationViewController as? ViewControllerRegistro
            
            destino!.telefono = txtNumero.text!
        }
    }


    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        if textField.tag == txtNumero.tag{
            let maxLength = 10
            let currentString: NSString = textField.text!
            let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        
        
        
        return true
    }
    


}

