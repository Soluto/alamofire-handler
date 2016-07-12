import XCTest
import Nimble
import AlamofireHandlers
import RxSwift
import RxBlocking

class AlamofireHandlerTests: XCTestCase {
    var handler: AlamofireHandler!
    
    override func setUp() {
        super.setUp()
        handler = AlamofireHandler()
    }
    
    func testSend_ValidRequest_ReturnValidResponse() throws{
        let request = NSMutableURLRequest(URL: NSURL(string: "https://httpbin.org/status/200")!)
        request.HTTPMethod = "GET"
        let result = try handler.send(request).toBlocking().single()
        expect(result?.response?.statusCode).toEventually(equal(200))
    }
    
    func testSend_BadRequest_ReturnError() {
        let request = NSMutableURLRequest(URL: NSURL(string: "omerl://httpbin.org/status/200")!)
        request.HTTPMethod = "GET"
        expect(try self.handler.send(request).toBlocking().single()).to(throwError())

    }
}
