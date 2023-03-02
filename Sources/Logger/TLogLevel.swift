//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Logging

public enum TLogLevel {
    case debug, info, warning, error, critical
}

public extension TLogLevel {
    func asLevel() -> Logging.Logger.Level {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .warning
        case .error:
            return .error
        case .critical:
            return .critical
        }
    }
}
