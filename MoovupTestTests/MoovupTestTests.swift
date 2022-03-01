//
//  MoovupTestTests.swift
//  MoovupTestTests
//
//  Created by Yansong Wang on 2022/3/1.
//

import XCTest
@testable import MoovupTest

class MoovupTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQuestion1() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let node_A = Node("A")
        let node_B = Node("B")
        let node_C = Node("C")
        let node_D = Node("D")
        let node_E = Node("E")
        let node_F = Node("F")
        let node_G = Node("G")
        let node_H = Node("H")

        node_A.links = [node_B, node_D, node_H]
        node_B.links = [node_A, node_D, node_C]
        node_C.links = [node_B, node_D, node_F]
        node_D.links = [node_B, node_C, node_A, node_E]
        node_E.links = [node_D, node_F, node_H]
        node_F.links = [node_C, node_E, node_G]
        node_G.links = [node_F, node_H]
        
        print(Node.getAllAvailablePath(first: node_A, last: node_H))
        print(Node.getShortestPath(first: node_A, last: node_H))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
