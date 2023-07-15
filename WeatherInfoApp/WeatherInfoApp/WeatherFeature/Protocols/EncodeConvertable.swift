//
//  EncodeConvertable.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 17/06/23.
//

import Foundation

protocol EncodeConvertable {
    func setEncodedData<Q> (toObject object: inout Q)
}

extension EncodeConvertable where Self: Codable {
    func setEncodedData<Q> (toObject object: inout Q) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            object = encoded as! Q
           }
    }
}
