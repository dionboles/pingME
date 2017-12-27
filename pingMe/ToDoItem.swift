//
//  ToDoItem.swift
//  pingMe
//
//  Created by Dion Boles on 12/27/17.
//  Copyright © 2017 Dion Boles. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var text: String
    var completed: Bool
    init(text:String){
        self.text = text;
        self.completed = false;
    }
}
