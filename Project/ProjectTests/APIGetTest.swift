import XCTest
@testable import Project

class APIGetTest: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        guard let url = URL(string: Url.getUsers.rawValue.urlValid) else { fatalError() }
        API.shared.get(.dataTask, URLRequest(url: url), { data in
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
