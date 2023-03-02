//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Logger
import Logging
import struct Logging.Logger
import os

public struct ConsoleLogHandler: LogHandler {
    public var logLevel: Logger.Level
    public let label: String
    private let oslogger: OSLog
    private let logQueue = DispatchQueue(label: "Logger")
    
    public init(label: String, logLevel: TLogLevel) {
        self.logLevel = logLevel.asLevel()
        self.label = label
        self.oslogger = OSLog(subsystem: label, category: "")
    }
    
    public func log(level: Logger.Level,
                    message: Logger.Message,
                    metadata: Logger.Metadata?,
                    file: String,
                    function: String,
                    line: UInt) {
        var combinedPrettyMetadata = self.prettyMetadata
        var metadataOverride = metadata ?? [:]
        metadataOverride["file"] = "\(file)"
        metadataOverride["function"] = "\(function)"
        metadataOverride["line"] = "\(line)"
        
        combinedPrettyMetadata = self.prettify(
            self.metadata.merging(metadataOverride) {
                return $1
            }
        )
        
        var formedMessage = message.description
        
        switch metadata?["tag"] {
        case .string(let tag):
            let tagOSLog = OSLog(subsystem: label, category: tag)
            logQueue.sync {
                os_log("%{public}@", log: tagOSLog, type: OSLogType.from(loggerLevel: level), formedMessage as NSString)
            }
        default:
            logQueue.sync {
                os_log("%{public}@", log: self.oslogger, type: OSLogType.from(loggerLevel: level), formedMessage as NSString)
            }
        }
    }
    
    private var prettyMetadata: String?
    public var metadata = Logger.Metadata() {
        didSet {
            self.prettyMetadata = self.prettify(self.metadata)
        }
    }
    
    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            return self.metadata[metadataKey]
        }
        set {
            self.metadata[metadataKey] = newValue
        }
    }
    
    private func prettify(_ metadata: Logger.Metadata) -> String? {
        if metadata.isEmpty {
            return nil
        }
        return metadata.map {
            "\($0): \($1)"
        }.joined(separator: "\n")
    }
}

extension OSLogType {
    static func from(loggerLevel: Logger.Level) -> Self {
        switch loggerLevel {
        case .trace:
            return .debug
        case .debug:
            return .info
        case .info:
            return .info
        case .notice:
            return .info
        case .warning:
            return .info
        case .error:
            return .error
        case .critical:
            return .fault
        }
    }
}
