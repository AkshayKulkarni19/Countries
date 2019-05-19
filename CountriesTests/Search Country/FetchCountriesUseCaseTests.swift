//
//  FetchCountriesUseCaseTests.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import XCTest
@testable import Countries

class FetchCountriesUseCaseTests: BaseTestCase {
    
    var usecase : FetchCountriesUseCase?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    override func configure() {
        let service = FetchCountriesServiceStub()
        let repository = FetchCountriesRepositoryStub(service: service)
        usecase = FetchCountriesUseCaseImpl(repository: repository)
    }
    
    func testFetchCoutriesFromAPI() {
        
        let expectation = XCTestExpectation(description: "result closure triggered")
        
        usecase?.fetchCountriesFromService(with: "a", completion: { (result) in
            switch result {
            case .success(let countries):
                
                XCTAssertEqual(countries.count, 13, "total countries count must be 13")
                
                XCTAssertNotNil(countries.first)
                XCTAssertEqual(countries.first?.callingCodes.count, 1, "first country callingCodes count must be 1")
                
                XCTAssertNotNil(countries.first?.capital)
                XCTAssertNotNil(countries.first?.flag)
                XCTAssertNotNil(countries.first?.languages)
                XCTAssertNotNil(countries.first?.name)
                XCTAssertEqual(countries.first?.callingCodes.count, 1, "first country callingCodes count must be 1")
                XCTAssertEqual(countries.first?.languages?.count, 1, "first country languages count must be 1")
                XCTAssertEqual(countries.first?.name, "Bonaire, Sint Eustatius and Saba", "first country name must be same")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        wait(for: [expectation], timeout: 10)
    }
    
}
