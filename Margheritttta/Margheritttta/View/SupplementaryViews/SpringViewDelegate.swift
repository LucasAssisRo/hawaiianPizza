//
//  SpringViewDelegate.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 14/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

protocol SpringViewDelegate {
    func expand(_ bounds: CGRect, with duration: TimeInterval)
    func colapse(_ bounds: CGRect, with duration: TimeInterval)
}
