//
//  String+Extensions.swift
//  FlexiblePickerExample
//
//  Created by Jędrzej Chołuj on 23/01/2022.
//

import UIKit

extension String {
    func getWidth(with font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func getHeight(with font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
