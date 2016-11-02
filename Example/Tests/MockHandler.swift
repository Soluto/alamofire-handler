import Foundation
import AlamofireHandlers
import RxSwift

open class MockHandler: URLRequestHandler {
    var lastRequest: URLRequest!
    var result: HttpRequestResult!
    var error: Error?
    
    open func send(request: URLRequest) -> Observable<DefaultDataResponse> {
        self.lastRequest = request
        if let error = self.error {
            return Observable.error(error)
        }
        return Observable.just(result)
    }
}
