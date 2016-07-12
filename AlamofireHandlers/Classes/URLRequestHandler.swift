import Foundation
import RxSwift

public protocol URLRequestHandler{
    func send(request: NSMutableURLRequest) -> Observable<HttpRequestResult>
}