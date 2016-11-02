import Foundation
import Alamofire
import RxSwift

public class DelegatingManager {
    let handler: URLRequestHandler
    
    public init(handler: URLRequestHandler){
        self.handler = handler
    }
    
    public func request(
        _ urlString: URLConvertible,
        method: HTTPMethod = .get,
        parameters:  Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> Observable<DefaultDataResponse>
    {
        do {
            let urlRequest = try URLRequest(url: urlString, method: method, headers: headers)
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return Observable.error(error)
        }
    }
    
    open func request(_ urlRequest: URLRequest) -> Observable<DefaultDataResponse> {
        do {
            return self.handler.send(request: urlRequest)
        } catch {
            return Observable.error(error)
        }
    }
}
