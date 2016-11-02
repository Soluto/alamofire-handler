import Foundation
import Alamofire

extension DefaultDataResponse {
    public func asJson(options: JSONSerialization.ReadingOptions = .allowFragments) -> Result<Any> {
        return DataRequest
            .jsonResponseSerializer(options: options)
            .serializeResponse(self.request, self.response, self.data, self.error)
    }
    
    public func asString(encoding: String.Encoding? = nil) -> Result<String> {
        return DataRequest
            .stringResponseSerializer(encoding: encoding)
            .serializeResponse(self.request, self.response, self.data, self.error)
    }
    
    public func asPropertyList(options: PropertyListSerialization.ReadOptions = []) -> Result<Any> {
        return DataRequest
            .propertyListResponseSerializer(options: options)
            .serializeResponse(self.request, self.response, self.data, self.error)
    }
    
    public func asData() -> Result<Data> {
        return DataRequest
            .dataResponseSerializer()
            .serializeResponse(self.request, self.response, self.data, self.error)
    }
}
