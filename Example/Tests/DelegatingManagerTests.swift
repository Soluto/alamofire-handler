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
        handler.result = HttpRequestResult(request: nil, response: nil, data: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
        
        try manager.request(request).toBlocking().single()
        
        expect(self.handler.lastRequest).to(equal(request))

    }
    
    func testRequest_ValidRequestButHandlerFailed_ReturnError() throws {
        handler.error = NSError(domain: "", code: 9, userInfo: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
        

        expect(try self.manager.request(request).toBlocking().single()).to(throwError())
    }
    
    func testRequest_InvalidStatusCodeReturned_RaisedError() throws {
        let response =  NSHTTPURLResponse.init(URL: NSURL(fileURLWithPath: "http://www.google.com"), statusCode: 400, HTTPVersion: nil, headerFields: nil)!
        handler.result = HttpRequestResult(request: nil, response: response, data: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
        
        expect(try self.manager.request(request).toBlocking().single()).to(throwError())
    }
    
}