import Foundation
import Alamofire
import RxSwift

public protocol URLRequestHandler {
    func send(request: URLRequest) -> Observable<DefaultDataResponse>
}
