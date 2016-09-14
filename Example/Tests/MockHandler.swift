import Foundation
import AlamofireHandlers
import RxSwift

open class MockHandler: URLRequestHandler{
    var lastRequest: NSMutableURLRequest!
    var result: HttpRequestResult!
    var error: NSError?
    
    open func send(_ request: NSMutableURLRequest) -> Observable<HttpRequestResult>{
        self.lastRequest = request
        if let error = self.error{
            return Observable.error(error)
        }
        return Observable.just(result)
    }
}
