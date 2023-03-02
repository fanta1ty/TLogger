//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Logging

public struct TLogger: Logger {
    
    private var logger: Logging.Logger
    
    public init(label: String = "TLogger",
                factory: ((String) -> LogHandler)? = nil) {
        if let factory = factory {
            logger = Logging.Logger(label: label, factory: factory)
        } else {
            logger = Logging.Logger(label: label)
        }
    }
    
    public func log(level: TLogLevel,
                    message: @autoclosure () -> String,
                    tag: String) {
        logger.log(
            level: level.asLevel(),
            .init(stringLiteral: message()),
            metadata: .init(dictionaryLiteral: ("tag", Logging.Logger.MetadataValue.string(tag))),
            source: nil,
            file: #file,
            function: #function,
            line: #line
        )
    }
}
