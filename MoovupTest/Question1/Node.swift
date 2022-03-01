//
//  Node.swift
//  TestMoovup
//
//  Created by Yansong Wang on 2022/3/1.
//

import Foundation

class Node: NSObject {
    let name: String
    var links: [Node]
    var cache: [Node]
    
    init(_ name: String) {
        self.name = name
        self.links = []
        self.cache = []
    }
    
    func isEqualTo(_ node: Node) -> Bool{
        return self.name == node.name
    }
    
    func nextNode(path: [Node]) -> Node? {
        for node in self.links {
            if !path.contains(node) && !self.cache.contains(node) {
                self.cache.append(node)
                return node
            }
        }
        self.clearCache()
        return nil
    }
    
    func clearCache() {
        self.cache = []
    }
    
    class func getAllAvailablePath(first: Node, last: Node) -> [[String]] {
        var results: [[String]] = []
        var path: [Node] = []
        path.append(first)
        
        while (path.count > 0) {
            let node = path[path.count - 1]
            if let next = node.nextNode(path: path) {
                path.append(next)
                if next.isEqualTo(last) {
                    var pathRes: [String] = []
                    for n in path {
                        pathRes.append(n.name)
                    }
                    results.append(pathRes)
                    path.removeLast()
                }
            } else {
                path.removeLast()
            }
        }
        
        
        return results
    }

    class func getShortestPath(first: Node, last: Node) -> [String] {
        var result: [String] = []
        
        let allPaths = Node.getAllAvailablePath(first: first, last: last)
        
        if allPaths.count == 0 {
            return result
        }
        
        result = allPaths[0]
        
        for path in allPaths {
            if path.count < result.count {
                result = path
            }
        }
        
        return result
    }
}
