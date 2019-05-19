//
//  FetchContriesServiceTest.swift
//  ContriesTests
//
//  Created by Akshay Kulkarni on 14/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import Countries

class FetchContriesServiceTest: XCTestCase {

    var service: FetchCountriesService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = FetchCountriesServiceImpl()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Validurl() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectaion = expectation(description: "country")
//        var contriesList: CountryResponse?
        service?.fetchCountriesFromJSON(withSearchText: "China", completion: { (countries) in
            XCTAssertNotNil(countries, "contriesList should not be nil")
            print(countries)
            expectaion.fulfill()
        })
        wait(for: [expectaion], timeout: 20)
        
    }
    
}
