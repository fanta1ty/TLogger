//  Created by Nguyen, Thinh on 02/03/2023.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

extension URLRequest {
    func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data = ""
        
        if let httpHeaders = allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
    
    func logMessage() -> String {
        var result = ""
        result += "🎯 Endpoint: \(url!)\n"
        result += "👤 Headers: \(allHTTPHeaderFields!)\n"
        result += "⚙️ Method: \(httpMethod!)\n"
        
        if let httpBody = httpBody {
            let bodyDict = try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]
            
            if let bodyDict = bodyDict {
                result += "📦 Body: \(bodyDict.prettyPrint())"
            } else if let resultString = String(data: httpBody, encoding: .utf8) {
                result += "📦 Body: \(resultString)"
            }
        }
        
        return result
    }
}

extension Dictionary where Key == String {
    func prettyPrint() -> String {
        var string = ""
        var options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, macOS 11, *) {
            options = [.prettyPrinted, .withoutEscapingSlashes]
        } else {
            options = [.prettyPrinted]
        }
        if let data = try? JSONSerialization.data(withJSONObject: self, options: options) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
}
