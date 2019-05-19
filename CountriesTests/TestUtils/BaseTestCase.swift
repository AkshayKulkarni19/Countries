//
//  BaseTestCase.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import Countries
import RealmSwift

class BaseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setTestDatabaseConfiguration()
        configure()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func setTestDatabaseConfiguration() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func clearDatabase() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func configure() {
        // Do any dependency injection in this method
    }
}
