import Foundation
import AlamofireHandlers
import RxSwift

public class MockHandler: URLRequestHandler{
    var lastRequest: NSMutableURLRequest!
    var result: HttpRequestResult!
    var error: NSError?
    
    public func send(request: NSMutableURLRequest) -> Observable<HttpRequestResult>{
        self.lastRequest = request
        if let error = self.error{
            return Observable.error(error)
        }
        return Observable.just(result)
    }
}