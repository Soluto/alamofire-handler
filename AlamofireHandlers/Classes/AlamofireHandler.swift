import Foundation
import Alamofire
import RxSwift

public class AlamofireHandler: URLRequestHandler {
    let manager: SessionManager
    
    public init(manager: SessionManager) {
        self.manager = manager
    }
    
    public func send(request: URLRequest) -> Observable<DefaultDataResponse>{
        return Observable.create{observer in
            let request = self.manager
                .request(request)
                .response { response in
                    if let error = response.error {
                        observer.onError(error)
                    }
                    observer.onNext(response)
                    observer.onCompleted()
                }
            
            return Disposables.create(with: { request.cancel() })
        }
    }
}
