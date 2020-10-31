import XCTest
@testable import Project

class APIPostTest: XCTestCase {
    
    let api: API = API.shared
    let met: httpMethod = .POST
    let url = URLs.post.urlValid
    private var parameters: [String:Any] = [:]
    let expectation = XCTestExpectation(description: "Exceeded waiting!")
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        for i in 0...9 {
            parameters.updateValue("Value \(i)", forKey: "APIPostTest \(i)")
        }
    }
    
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
        
    func testExample() throws {
        XCTAssertFalse(parameters.isEmpty, "parameters should not be empty!")
        
        api.post(met, url, parameters, completion: { [self] data -> Void in
            XCTAssertNotNil(data, "Failed to execute POST request (data: nil)")
            guard let data = data, let answer = String(data: data, encoding: .utf8) else { return }
            print("✅ Server confirm: \(answer)")
            expectation.fulfill()
        })
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1) // ждет ответ указанное время
        XCTAssertEqual(result, .completed) // остановка теста, если ответ пришел раньше
    }

    func testPerformanceExample() throws {
        self.measure { }
    }
}
