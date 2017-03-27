//
//  CollectionViewController.swift
//  pFinal
//
//  Created by Alejandro  Gutierrez on 26/03/17.
//  Copyright © 2017 Alejandro  Gutierrez. All rights reserved.
//

import UIKit
import Foundation


class CollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectV: UICollectionView!
    let reuseIdentifier = "cell"
    var list:Array<Fruta> = []
    
    struct Fruta {
        var titulo = ""
        var imagen = ""
    }
    
    


    
    func readJson(){
        
        // Definimos String para convertirlo en Json
        let str = "[ { \"titulo\":\"AGUACATE\",\"imagen\":\"aguacate.png\"},{ \"titulo\":\"CALABAZA\", \"imagen\":\"calabaza.png\"},{ \"titulo\":\"CEREZA\", \"imagen\":\"cereza.png\"},{ \"titulo\":\"DURAZNO\",\"imagen\":\"durazno.png\"},{ \"titulo\":\"FRAMBUESA\",\"imagen\":\"frambuesa.png\"},{ \"titulo\":\"FRESA\",\"imagen\":\"fresa.png\"},{ \"titulo\":\"GRANADA\",\"imagen\":\"granada.png\"},{ \"titulo\":\"KIWI\",\"imagen\":\"kiwi.png\"},{ \"titulo\":\"LIMON\",\"imagen\":\"limon.png\"},{ \"titulo\":\"MANZANA\",\"imagen\":\"manzana.png\"},{ \"titulo\":\"MELON\",\"imagen\":\"melon.png\"},{ \"titulo\":\"NARANJA\",\"imagen\":\"naranja.png\"},{ \"titulo\":\"PERA\",\"imagen\":\"pera.png\"},{ \"titulo\":\"PINA\",\"imagen\":\"pina.png\"},{ \"titulo\":\"PLATANO\",\"imagen\":\"platano.png\"},{ \"titulo\":\"SANDIA\",\"imagen\":\"sandia.png\"},{ \"titulo\":\"TORONJA\",\"imagen\":\"toronja.png\"},{ \"titulo\":\"LOGOUT\",\"imagen\":\"logout.png\"} ]"
        
        let json: AnyObject? = str.parseJSONString
        print("Parsed JSON: \(json!)")
        print("json[3]: \(json![3])")
        
        // convert 'AnyObject' to Array<Business>
        list = self.parseJson(json!)
  

        }
    
    func parseJson(anyObj:AnyObject) -> Array<Fruta>{
        var list:Array<Fruta> = []
        
        if  anyObj is Array<AnyObject> {
            var b:Fruta = Fruta()
            for json in anyObj as! Array<AnyObject>{
                b.titulo = (json["titulo"] as AnyObject? as? String) ?? ""
                b.imagen  =  (json["imagen"]  as AnyObject? as? String) ?? ""
                list.append(b)
            }// for
        } // if
        return list
    }//func
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return list.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return  1//row number
    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Configure the cell
        cell.imgView.image = UIImage(named: self.list[indexPath.item].imagen )

        cell.lblTitulo.text = self.list[indexPath.item].titulo
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    
       func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let width = (self.view.bounds.width/3 ) //some width
        return CGSize(width: width, height: width);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let titleSelected = list[indexPath.row].titulo as String
            if titleSelected=="LOGOUT"{
                performSegueWithIdentifier("logout", sender: self)
        }
    }

    
   
}


extension String
{
    var parseJSONString: AnyObject?
        {
            let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            if let jsonData = data
            {
                // Will return an object or nil if JSON decoding fails
                do
                {
                    let message = try NSJSONSerialization.JSONObjectWithData(jsonData, options:.MutableContainers)
                    if let jsonResult = message as? NSMutableArray
                    {
                        print(jsonResult)
                        
                        return jsonResult //Will return the json array output
                    }
                    else
                    {
                        return nil
                    }
                }
                catch let error as NSError
                {
                    print("An error occurred: \(error)")
                    return nil
                }
            }
            else
            {
                // Lossless conversion of the string was not possible
                return nil
            }
    }
}