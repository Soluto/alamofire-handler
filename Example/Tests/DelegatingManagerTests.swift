import XCTest
import Nimble
import AlamofireHandlers
import Alamofire
import RxSwift
import RxBlocking

class DelegatingManagerTests: XCTestCase {
    var handler: MockHandler!
    var manager: DelegatingManager!
    
    override func setUp() {
        super.setUp()
        
        handler = MockHandler()
        manager = DelegatingManager(handler: handler)
    }
    
    func testRequest_ValidRequest_HandlerCalledWithCorrectRequest() throws {
        handler.result = DefaultDataResponse(request: nil, response: nil, data: nil)
        let request = URLRequest(url: URL(string: "blah")!)
        
        try manager.request(request).toBlocking().single()
        
        expect(self.handler.lastRequest).to(equal(request))

    }
    
    func testRequest_ValidRequestButHandlerFailed_ReturnError() throws {
        handler.error = NSError(domain: "", code: 9, userInfo: nil)
        let request = URLRequest(url: URL(string: "blah")!)

        expect(try self.manager.request(request).toBlocking().single()).to(throwError())
    }
    
    func testRequest_InvalidStatusCodeReturned_RaisedError() throws {
        let response =  HTTPURLResponse.init(url: URL(fileURLWithPath: "http://www.google.com"), statusCode: 400, httpVersion: nil, headerFields: nil)!
        handler.result = DefaultDataResponse(request: nil, response: response, data: nil)
        let request = URLRequest(url: URL(string: "blah")!)
        
        expect(try self.manager.request(request).toBlocking().single()).to(throwError())
    }
    
}
