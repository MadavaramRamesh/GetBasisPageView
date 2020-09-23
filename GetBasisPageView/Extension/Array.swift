//
//  Array.swift
//  GetBasisPageView
//
//  Created by Test on 23/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import UIKit
///
/// Repeates the same elements to create new array
/// `count` length of the newly created array
/// `repeatedValues` static array contains limited number of elements

extension Array {
    init?(count: Int, repeatedValues: [Element]) {
        var arr = [Element]()
        for _ in 0...(count/repeatedValues.count) {
            arr += repeatedValues
        }
        self = Array(arr[0..<count])
    }
}
