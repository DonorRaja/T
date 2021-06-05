//
//  Model.swift
//  Dummy
//
//  Created by DonorRaja on 5/06/21.
//

import Foundation

class AlbumModel {

var id: String?
var completed: String?
var title: String?
var userId: String?

init(id: String?, userId: String?, title: String?, completed: String?){

    self.id = id
    self.userId = userId
    self.title = title
    self.completed = completed

   }
}
