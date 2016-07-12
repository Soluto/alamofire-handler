import Foundation
import Alamofire
import RxSwift

public class AlamofireHandler: URLRequestHandler{
    let manager: Manager
    
    public init(manager: Manager){
        self.manager = manager
    }
    
    public convenience init(){
        self.init(manager: Manager.sharedInstance)
    }
    
    public func send(request: NSMutableURLRequest) -> Observable<HttpRequestResult>{
        return Observable.create{observer in
            let request = self.manager.request(request).response{(request, response, data, err) in
                if let error = err {
                    observer.onError(error)
                }
                
                observer.onNext(HttpRequestResult(request: request, response: response, data: data))
                observer.onCompleted()
            }
            
            return AnonymousDisposable {
                request.cancel()
            }
        }
        
    }
}