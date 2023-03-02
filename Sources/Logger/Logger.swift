//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Logging
import Foundation

public typealias LogHandler = Logging.LogHandler

public protocol Logger {
    func log(level: TLogLevel,
             message: @autoclosure () -> String,
             tag: String)
}

public extension Logger {
    
    func log(level: TLogLevel,
             message: @autoclosure () -> String,
             taggable: Taggable.Type) {
        log(level: level, message: message(), tag: taggable.tag)
    }
    
    func logError(message: @autoclosure () -> String,
                  error: Error,
                  taggable: Taggable.Type) {
        let errorMessage: String
        if let debugStringConvertible =  error as? CustomDebugStringConvertible {
            errorMessage = "\(message()): \(debugStringConvertible.debugDescription)"
        } else if let stringConvertible =  error as? CustomStringConvertible {
            errorMessage = "\(message()): \(stringConvertible.description)"
        } else {
            errorMessage = "\(message()): \(error.localizedDescription)"
        }
        log(level: .error, message: errorMessage, tag: taggable.tag)
    }
}
