//
//  LocalizedStringExtension.swift
//  Margheritttta
//
//  Created by Marco Romano on 27/04/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "*NOT FOUND\(self)**", comment: "")
    }
}
