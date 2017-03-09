//
//  ColorRGBExtension.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 09/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData

extension ColorRGB {
    static func create(redColor red: Float, greenColor green: Float, blueColor blue: Float,alphaOpacity alpha: Float) -> ColorRGB
    {
        let color = ColorRGB(context: CoreDataManager.context)
        color.red = red
        color.green = green
        color.blue = blue
        color.alpha = alpha
        CoreDataManager.save()
        return color
        
    }
}
