//
//  LRUCacheManager.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/27/24.
//

import Foundation
import UIKit


let capacity: Int = 20
var list = DoublyLinkedList<CachePayload>()
var nodesDict: [String: Node<CachePayload>] = [:] {
    didSet {
        let imageDataArr = nodesDict.values.map({$0.payload.value.pngData()})
        let encoder = JSONEncoder()
        cachedImageData = try? encoder.encode(imageDataArr)
    }
}

var cachedImageData: Data? {
    get {
        return UserDefaults.standard.object(forKey: "cached_images") as? Data
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "cached_images")
        UserDefaults.standard.synchronize()
    }
}

struct CachePayload {
    let key: String
    let value: UIImage
}

final class Node<T> {
    var payload: T
    var previous: Node<T>?
    var next: Node<T>?
    
    init(payload: T) {
        self.payload = payload
    }
}

final class DoublyLinkedList<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    private(set) var count: Int = 0
    
    func addHead(_ payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }

        guard let head = head else {
            tail = node
            return node
        }

        head.previous = node
        node.previous = nil
        node.next = head

        return node
    }
    
    func moveToHead(_ node: Node<T>) {
        guard node !== head else { return }
        let previous = node.previous
        let next = node.next

        previous?.next = next
        next?.previous = previous

        node.next = head
        node.previous = nil

        if node === tail {
            tail = previous
        }

        self.head = node
    }

    func removeLast() -> Node<T>? {
        guard let tail = tail else { return nil }
        let prevNode = tail.previous
        tail.previous = nil
        self.tail = prevNode
        if prevNode == nil {
            self.head = nil
        } else {
            prevNode?.next = nil
        }
        count -= 1
        return tail
    }

    
}


final class CacheLRU {
    func setValue(_ value: UIImage, for key: String) {
        let payload = CachePayload(key: key, value: value)
        
        if let node = nodesDict[key] {
            node.payload = payload
            list.moveToHead(node)
        } else {
            let node = list.addHead(payload)
            nodesDict[key] = node
        }
        
        if list.count > capacity {
            let nodeRemoved = list.removeLast()
            if let key = nodeRemoved?.payload.key {
                nodesDict[key] = nil
            }
        }
    }

    func getValue(for key: String) -> UIImage? {
        guard let node = nodesDict[key] else { return nil }
        
        list.moveToHead(node)
        
        return node.payload.value
    }

    func getAllImages() -> [UIImage] {
        
        let decoder = JSONDecoder()
        let dataArr = try? decoder.decode([Data].self, from: cachedImageData ?? Data())
        var imageArr: [UIImage] = []
        if let dataArr = dataArr {
            for item in dataArr {
                if let img = UIImage(data: item) {
                    imageArr.append(img)
                }
            }
        }
        return imageArr
    }
}


