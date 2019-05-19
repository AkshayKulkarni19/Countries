//
//  String+Extension.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

extension String{
    var localized:String {
        return NSLocalizedString(self, tableName: "Main", bundle: .main, value: "\(self)", comment: "")
    }
}
