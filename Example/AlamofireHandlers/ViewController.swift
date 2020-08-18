import UIKit
import Alamofire
import AlamofireHandlers
import RxSwift

class ViewController: UIViewController {
    fileprivate let bag : DisposeBag = { return DisposeBag() }()

    fileprivate lazy var innerManager: SessionManager = {
        let configuration = URLSessionConfiguration.default

        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60

        let manager = SessionManager(configuration: configuration)
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = DelegatingManager(handler: AlamofireHandler(manager: innerManager))
        manager.request("https://httpbin.org/headers").subscribe(onNext: { result in
            print(result.asString())
        }).addDisposableTo(bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
