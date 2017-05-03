//
//  Random.swift
//  flapping bird
//
//  Created by Rus Razvan on 03/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    
    public static func randomBetweenNumbers(firstNum: CGFloat, secoundNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * Swift.abs(firstNum - secoundNum) + firstNum
    }
    
}

























