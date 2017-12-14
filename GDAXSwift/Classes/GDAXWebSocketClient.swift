//
//  GDAXWebSocket.swift
//  GDAXSwift
//
//  Created by Daniel Brooks on 12/13/17.
//

import Foundation
import Starscream

public class GDAXWebSocketClient : WebSocketDelegate {
    
    public let gdaxClient: GDAXClient
    
    private let socket = WebSocket(url: URL(string: "wss://ws-feed.gdax.com")!)
    
    internal init(gdaxClient: GDAXClient) {
        self.gdaxClient = gdaxClient
    }
    
    public func start() {
        socket.delegate = self
        socket.connect()
        
        let request = GDAXSubscriptionRequest(channels: [GDAXChannel(productIds: ["BTC-USD"], name: GDAXChannelName.heartbeat.rawValue)])
        socket.write(data: request.asJSON()!)
    }
    
    // MARK: Websocket Delegate Methods.
    
    public func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received text: \(text)")
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    public func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        print("Got pong! Maybe some data: \(data?.count)")
    }
}
