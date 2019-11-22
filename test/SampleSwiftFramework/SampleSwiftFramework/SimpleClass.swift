//
//  SimpleClass.swift
//  SampleSwiftFramework
//
//  Created by Igor Ferreira on 22/11/2019.
//  Copyright © 2019 Future Workshops. All rights reserved.
//

import Foundation

/// Simple class used to test documentation definition
public struct SimpleClass {
    /// ID definition of the class
    public let id: String
    
    /// Simply return the value stored as id
    func showId() -> String {
        return self.id
    }
    
    /// Returns a complete object, made as \(element)_\(self.id)
    /// - Parameter element: String to be prepended
    func compose(element: String) -> String {
        return "\(element)_\(self.id)"
    }
}
