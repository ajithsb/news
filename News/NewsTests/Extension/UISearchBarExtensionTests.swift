//
//  UISearchBarExtensionTests.swift
//  NewsTests
//
//  Created by Aj on 22/07/24.
//

import XCTest
@testable import News

class UISearchBarExtensionTests: XCTestCase {

    func testApplyTextFieldBorder() {
        // Create a UISearchBar instance
        let searchBar = UISearchBar()
        
        // Trigger the creation of the search field
        searchBar.searchTextField.text = "Sample"
        
        // Call the method to apply the border
        searchBar.applyTextFieldBorder()
        
        // Access the text field inside the search bar
        guard let textField = searchBar.value(forKey: "searchField") as? UITextField else {
            XCTFail("Text field not found")
            return
        }
        
        // Check the border style
        XCTAssertEqual(textField.borderStyle, .none, "Border style should be none")
        
        // Check the corner radius
        XCTAssertEqual(textField.layer.cornerRadius, 10, "Corner radius should be 10")
        
        // Check if the text field's borders are visible
        XCTAssertEqual(textField.layer.borderWidth, 1.0, "Border width should be 1.0")
        XCTAssertEqual(textField.layer.borderColor, UIColor.lightGray.cgColor, "Border color should be light gray")
        
        // Check the background color
        XCTAssertEqual(textField.backgroundColor, .white, "Background color should be white")
    }
}
