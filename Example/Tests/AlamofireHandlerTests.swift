import XCTest
import Nimble
import Alamofire
import AlamofireHandlers
import RxSwift
import RxBlocking

class AlamofireHandlerTests: XCTestCase {
    var handler: AlamofireHandler!
    
    override func setUp() {
        super.setUp()
		handler = AlamofireHandler(manager: SessionManager())
    }
    
    func testSend_ValidRequest_ReturnValidResponse() throws{
        var request = URLRequest(url: URL(string: "https://httpbin.org/status/200")!)
		request.httpMethod = HTTPMethod.get.rawValue
		let result = try handler.send(request: request).toBlocking().single()
        expect(result?.response?.statusCode).toEventually(equal(200))
    }
    
    func testSend_BadRequest_ReturnError() {
        var request = URLRequest(url: URL(string: "omerl://httpbin.org/status/200")!)
        request.httpMethod = HTTPMethod.get.rawValue
		expect(try self.handler.send(request: request).toBlocking().single()).to(throwError())

    }
}
