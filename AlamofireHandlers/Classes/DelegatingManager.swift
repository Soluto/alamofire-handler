import Foundation
import Alamofire
import PromiseKit

public class DelegatingManager{
    let handler: URLRequestHandler
    
    public init(handler: URLRequestHandler){
        self.handler = handler
    }
    
    public func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: ParameterEncoding = .URL,
          headers: [String: String]? = nil)
        -> Promise<HttpRequestResult>
    {
        let mutableURLRequest = URLRequest(method, URLString, headers: headers)
        let encodedURLRequest = encoding.encode(mutableURLRequest, parameters: parameters).0
        return self.request(encodedURLRequest)
    }
    
    public func request(URLRequest: URLRequestConvertible) -> Promise<HttpRequestResult> {
        return self.handler.send(URLRequest.URLRequest)
    }
    
    func URLRequest(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          headers: [String: String]? = nil)
        -> NSMutableURLRequest
    {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let headers = headers {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        return mutableURLRequest
    }
}