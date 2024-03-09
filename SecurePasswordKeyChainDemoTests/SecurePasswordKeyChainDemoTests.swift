//
//  SecurePasswordKeyChainDemoTests.swift
//  SecurePasswordKeyChainDemoTests
//
//  Created by Ravikanth on 09/03/2024.
//

import XCTest
@testable import SecurePasswordKeyChainDemo

final class SecurePasswordKeyChainDemoTests: XCTestCase {

    func test_Add_SecureItem_To_Store() {
        XCTAssertTrue(secureStore(secret: "password", forKey: "Username"))
    }
    
    func test_Update_Success_SecureItem_To_Store() {
        // Add the item
        XCTAssertTrue(secureStore(secret: "password", forKey: "Username_One"))
        // Update the item
        XCTAssertTrue(secureStore(secret: "Newpassword", forKey: "Username_One"))
    }
    
    func test_Delete_SecureItem_From_Store() {
        
        XCTAssertTrue(secureStore(secret: "password", forKey: "Username_two"))
        XCTAssertTrue(deleteItem(forKey: "Username_two"))
    }
}
