//
//  GDAXSubscriptionRequest.swift
//  GDAXSwift
//s
//  Created by Daniel Brooks on 12/13/17.
//

import Foundation

public struct GDAXSubscriptionRequest: JSONConvertible {
    
    public var type: String = "subscribe"
    public let channels: [GDAXChannel]
    
    internal init(channels: [GDAXChannel]) {
        self.channels = channels
    }
    

    public func asJSON() -> [String : Any] {
        var json: [String: Any] = [
            "type": type,
        ]
        
        var products: [Any] = []
        
        for channel in channels {
            let json1: [String: Any] = [
                "name": channel.name!,
                "product_ids": channel.productIds
            ]
            products.append(json1)
        }
        
        json["channels"] = products
        
        return json
    }
}
