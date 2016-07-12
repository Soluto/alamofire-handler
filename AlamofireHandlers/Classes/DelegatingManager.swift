import Foundation
import Alamofire
import RxSwift

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
        -> Observable<HttpRequestResult>
    {
        let mutableURLRequest = URLRequest(method, URLString, headers: headers)
        let encodedURLRequest = encoding.encode(mutableURLRequest, parameters: parameters).0
        return self.request(encodedURLRequest)
    }
    
    public func request(URLRequest: URLRequestConvertible) -> Observable<HttpRequestResult> {
        return self.handler.send(URLRequest.URLRequest).map({ result in
            if let response = result.response{
                if !(200 ... 299 ~= response.statusCode){
                    let failureReason = "Response status code was unacceptable: \(response.statusCode)"
                    
                    let error = NSError(
                        domain: Error.Domain,
                        code: Error.Code.StatusCodeValidationFailed.rawValue,
                        userInfo: [
                            NSLocalizedFailureReasonErrorKey: failureReason,
                            Error.UserInfoKeys.StatusCode: response.statusCode
                        ]
                    )
                    
                    throw error
                }
            }
            
            return result
        })
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