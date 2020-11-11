import XCTest
@testable import Project

class APIPostTest: XCTestCase {
    
    let api: API = API.shared
    let met: httpMethod = .POST
    private var params: [String:Any] = [:]
    let expectation = XCTestExpectation(description: "Exceeded waiting!")
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        for i in 0...9 {
            params.updateValue("Value \(i)", forKey: "APIPostTest \(i)")
        }
    }
    
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
        
    func testExample() throws {
        XCTAssertFalse(params.isEmpty, "parameters should not be empty!")
        guard let url = URL(string: Url.post.rawValue.urlValid) else { fatalError() }
        API.shared.post(.contentType, URLRequest(url: url), params, { [self] data -> Void in
            XCTAssertNotNil(data, "Failed to execute POST request (data: nil)")
            guard let answer = String(data: data, encoding: .utf8) else { return }
            print("✅ Server confirm: \(answer)")
            expectation.fulfill()
        })
                
        let result = XCTWaiter.wait(for: [expectation], timeout: 3) // ждет ответ указанное время
        XCTAssertEqual(result, .completed) // остановка теста, если ответ пришел раньше
    }

    func testPerformanceExample() throws {
        self.measure { }
    }
}
