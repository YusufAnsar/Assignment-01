//
//  CoinsServiceTests.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import XCTest

final class CoinsServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoinsServiceMock() async throws {
        let serviceMock = CoinsServiceMock()
        let result = await serviceMock.getCoins()

        switch result {
        case .success(let response):
            XCTAssertEqual(response.count, 26, "Invalid response")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
}