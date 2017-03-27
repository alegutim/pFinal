//
//  USUARIOS+CoreDataProperties.swift
//  pFinal
//
//  Created by Alejandro  Gutierrez on 25/03/17.
//  Copyright © 2017 Alejandro  Gutierrez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension USUARIOS {

    @NSManaged var telefono: String
    @NSManaged var contrasena: String
    @NSManaged var correo: String

}
