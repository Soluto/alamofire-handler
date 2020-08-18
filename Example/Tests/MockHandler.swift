import Foundation
import Alamofire
import AlamofireHandlers
import RxSwift

open class MockHandler: URLRequestHandler {
    var lastRequest: URLRequest!
    var result: DefaultDataResponse!
    var error: Error?
    
    open func send(request: URLRequest) -> Observable<DefaultDataResponse> {
        print("adding this prevent unit tests runtime error")

        self.lastRequest = request
        if let error = self.error {
            return Observable.error(error)
        }
        return Observable.just(result)
    }
}
