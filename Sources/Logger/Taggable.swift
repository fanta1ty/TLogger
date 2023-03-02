//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

public protocol Loggable {
    var logger: Logger { get }
}

public protocol Taggable {
    static var tag: String { get }
}

public extension Loggable where Self: Taggable {
    func log(level: TLogLevel,
             message: @autoclosure () -> String) {
        logger.log(level: level, message: message(), taggable: Self.self)
    }
}
