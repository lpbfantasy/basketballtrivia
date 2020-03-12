//
//  APIClass.swift
//  BasketballTrivia
//
//  Created by IOS on 05/03/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

class APIClass: NSObject
{
    static let shared = APIClass()
       private override init() {
           
       }
    
    
    var getQuestions = "http://kistchatstorage.com/BasketballTrivia/getQuestionsForLevel.php?level=\(BBallTriviaSingleton.shared.level)"
}
