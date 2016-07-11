import Foundation
import AlamofireHandlers
import PromiseKit

public class MockHandler: URLRequestHandler{
    var lastRequest: NSMutableURLRequest!
    var result: HttpRequestResult?
    var error: NSError?
    
    public func send(request: NSMutableURLRequest) -> Promise<HttpRequestResult>{
        self.lastRequest = request
        if let error = self.error{
            return Promise(error: error)
        }
        return Promise(self.result!)
    }
}