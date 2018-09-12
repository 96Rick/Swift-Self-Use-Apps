//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by Rick on 2018/9/10.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_weatherDataAt_starts_the_session() {
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        manager.weatherDataAt(latitude: 10, longitude: 20, completion: { _, _ in })
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_get_data() {
        var data: WeatherData? = nil
        
        let expect = expectation(description: "Loading data frome \(API.authenticatedURL)")
        WeatherDataManager.shared.weatherDataAt(latitude: 30, longitude: 20, completion: {(response, error) in data = response
            expect.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil  )
        XCTAssertNotNil(data)
    }
    

}
