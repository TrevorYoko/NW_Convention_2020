//
//  CustomFlowLayout.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/12/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import Foundation
import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
