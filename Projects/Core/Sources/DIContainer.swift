//
//  DIContainer.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import Foundation

public final class DIContainer {
    static var storage: [String: Any] = [:]
    private static let queue = DispatchQueue(label: "DIContainerQueue", attributes: .concurrent)
    
    public static func register<T>(type: T.Type, _ object: T) {
          queue.async(flags: .barrier) {
              storage[String(describing: type)] = object
          }
      }
    
    public static func resolve<T>(type: T.Type) -> T {
        var result: T?
        queue.sync {
            result = storage[String(describing: type)] as? T
        }
        guard let object = result else {
            fatalError("register 되지 않은 객체 호출: \(type)")
        }
        return object
    }
}
