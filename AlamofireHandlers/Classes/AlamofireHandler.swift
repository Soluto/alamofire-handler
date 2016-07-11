import Foundation
import Alamofire
import PromiseKit

public class AlamofireHandler: URLRequestHandler{
    let manager: Manager
    
    public init(manager: Manager){
        self.manager = manager
    }
    
    public convenience init(){
        self.init(manager: Manager.sharedInstance)
    }
    
    public func send(request: NSMutableURLRequest) -> Promise<HttpRequestResult>{
        return Promise{fulfill, reject in
            self.manager.request(request).validate().response{(request, response, data, err) in
                if let error = err {
                    reject(error)
                }
                
                fulfill(HttpRequestResult(request: request, response: response, data: data))
            }
        }
        
    }
}