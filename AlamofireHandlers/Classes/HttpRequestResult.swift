import Foundation
import Alamofire

public struct HttpRequestResult {
    public let request: NSURLRequest?
    public let response: NSHTTPURLResponse?
    public let data: NSData?
    
    public init(request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?){
        self.request = request
        self.response = response
        self.data = data
    }
}

extension HttpRequestResult {
    public func serialize<T: ResponseSerializerType>(responseSerializer: T) -> Response<T.SerializedObject, T.ErrorObject> {
        let result = responseSerializer.serializeResponse(
            self.request,
            self.response,
            self.data,
            nil
        )
        
        return Response<T.SerializedObject, T.ErrorObject>(
            request: self.request,
            response: self.response,
            data: self.data,
            result: result
        )
    }
    
    public func serializeData() -> Response<NSData, NSError>{
        return self.serialize(Request.dataResponseSerializer())
    }
    
    public func serializeString() -> Response<String, NSError> {
        return self.serialize(Request.stringResponseSerializer())
    }
    
    public func serializeJSON() -> Response<AnyObject, NSError> {
        return self.serialize(Request.JSONResponseSerializer())
    }
}