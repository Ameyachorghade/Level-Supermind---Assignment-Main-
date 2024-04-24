//
//  myTvCellDataModel.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 25/04/24.
//

import Foundation
import UIKit

struct myTvCellDataModel {
    let image: UIImage
    let title: String
    let description: String
    let additionalInfo: String
    var isLiked:Bool
}

// This extension provides a method to generate random data
extension myTvCellDataModel {
    static func generateRandomData() -> myTvCellDataModel {
        // Generate random UIImage (Replace "placeholderImage" with your actual image)
        let randomImage = UIImage(named: "image1")!
        
        // Generate random strings for title, description, and additional info
        let randomTitle = "Title \(Int.random(in: 1...100))"
        let randomDescription = "Description \(Int.random(in: 1...100))"
        let randomAdditionalInfo = "Additional Info \(Int.random(in: 1...100))"
        
        // Create a MyData instance with the random data
        return myTvCellDataModel(image: randomImage, title: randomTitle, description: randomDescription, additionalInfo: randomAdditionalInfo, isLiked: false)
    }
}
