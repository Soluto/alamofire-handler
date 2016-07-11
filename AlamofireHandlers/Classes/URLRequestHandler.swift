import Foundation
import PromiseKit

public protocol URLRequestHandler{
    func send(request: NSMutableURLRequest) -> Promise<HttpRequestResult>
}