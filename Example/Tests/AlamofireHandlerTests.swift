import Quick
import Nimble
import AlamofireHandlers
import PromiseKit

class AlamofireHandlerTests: QuickSpec {
    override func spec() {
        describe("AlamofireHandler"){
            var handler: AlamofireHandler!
            beforeEach{handler = AlamofireHandler()}
            
            it("Should return response on successfull request"){
                let request = NSMutableURLRequest(URL: NSURL(string: "https://httpbin.org/status/200")!)
                request.HTTPMethod = "GET"
                let promise = handler.send(request)
                expect(promise.fulfilled).toEventually(beTrue())
                expect(promise.value?.response?.statusCode).toEventually(equal(200))
            }
            
            it("Should fail on failed request"){
                let request = NSMutableURLRequest(URL: NSURL(string: "omerl://httpbin.org/status/200")!)
                request.HTTPMethod = "GET"
                let promise = handler.send(request)
                expect(promise.rejected).toEventually(beTrue())
            }
            
        }
    }
}
