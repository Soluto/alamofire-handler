import Quick
import Nimble
import AlamofireHandlers
import Alamofire

class DelegatingManagerTests: QuickSpec {
    override func spec() {
        describe("DelegatingManager") {
            var handler: MockHandler!
            var manager: DelegatingManager!
            
            beforeEach({
                handler = MockHandler()
                manager = DelegatingManager(handler: handler)
            })
            
            it("Should call handler with passed request"){
                handler.result = HttpRequestResult(request: nil, response: nil, data: nil)
                let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
                
                let result = manager.request(request)
                
                expect(result.fulfilled).toEventually(beTrue())
                expect(handler.lastRequest).to(equal(request))
            }
            
            describe("handler failed sending the request") {
                it("should return the error"){
                    handler.error = NSError(domain: "", code: 9, userInfo: nil)
                    let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
                    
                    let result = manager.request(request)
                    
                    expect(result.rejected).toEventually(beTrue())
                }
            }
            
            describe("response status code is invalid") {
                it("should return error"){
                    let response =  NSHTTPURLResponse.init(URL: NSURL(fileURLWithPath: "http://www.google.com"), statusCode: 400, HTTPVersion: nil, headerFields: nil)!
                    handler.result = HttpRequestResult(request: nil, response: response, data: nil)
                    let request = NSMutableURLRequest(URL: NSURL(string: "blah")!)
                    
                    let result = manager.request(request)
                    
                    expect(result.rejected).toEventually(beTrue())
                }
            }
        }
    }
}
