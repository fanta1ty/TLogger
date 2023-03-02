//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Logger

public extension Logger {
    public func log(
        request: URLRequest? = nil,
        data: Data? = nil,
        response: HTTPURLResponse? = nil,
        error: Error? = nil,
        tag: String
    ) {
        
        var message = ""
        if let request = request {
            message += "\n⬅️⬅️⬅️⬅️⬅️ Request:\n\(request.logMessage())"
        }
        
        message += "\n\n➡️➡️➡️➡️➡️ Response:\n"
        
        if let statusCode = response?.statusCode {
            message += "🔢 Status code: \(statusCode)\n"
        }
        
        if let headers = response?.allHeaderFields as? [String: AnyObject] {
            message += "👤 Headers: \(headers.prettyPrint())\n"
        }
        
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                message += "📦 Payload: \(json.prettyPrint())\n"
            } else {
                message += "📦 Payload: \(String(data: data, encoding: .utf8) ?? "")\n"
            }
        }
        
        if let error = error {
            message += "⛔️ Error: \(error.localizedDescription)\n"
            log(level: .error, message: message, tag: tag)
        } else {
            log(level: .debug, message: message, tag: tag)
        }
    }
}
