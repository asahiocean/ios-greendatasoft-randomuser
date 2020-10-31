import XCTest
@testable import Project

class APIGetTest: XCTestCase {
        
    let api: API = API()
    let getMethod: httpMethod = .GET
    let getUrl = URLs.get
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        api.get(method: getMethod, url: getUrl, completion: { data in
            if let data = data {
                do {
                    print(try JSONSerialization.jsonObject(with: data, options: []))
                } catch let APIGetTestError as NSError {
                    print("\(type(of: self)).APIGetTestError:", APIGetTestError.localizedDescription)
                }
            } else {
                XCTFail("🔴 Failed to execute GET request")
            }
        })
    }

    func testPerformanceExample() throws {
        self.measure {
            // try? testExample()
        }
    }
}
