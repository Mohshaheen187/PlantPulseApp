//
//  String.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 05.12.23.
//

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
