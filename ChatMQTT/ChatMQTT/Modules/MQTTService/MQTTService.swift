//
//  MQTTService.swift
//  MessageModule
//
//  Created by Anh Tuan Nguyen on 19/02/2017.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import CocoaMQTT
import SwiftyJSON
import UIKit

class MQTTService {
    static let sharedInstance = MQTTService()
    
    var mqtt: CocoaMQTT?
    
    var topics = [String]()
    
    
    private init(){
        //Setting SSL
        selfSignedSSLSetting()
    }
    
    private func settingMQTT(){
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "35.161.100.32", port: 1883)
        mqtt?.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt?.keepAlive = 60
        mqtt?.delegate = self
    }
    
    func simpleSSLSetting() {
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "35.161.100.32", port: 8883)
        mqtt!.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt!.keepAlive = 60
        mqtt!.delegate = self
        mqtt!.enableSSL = true
    }
    
    
    func selfSignedSSLSetting() {
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "35.161.100.32", port: 8883)
        mqtt!.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt!.keepAlive = 60
        mqtt!.delegate = self
        mqtt!.enableSSL = true
        
        let clientCertArray = getClientCertFromP12File(certName: "ca", certPassword: "admin")
        
        var sslSettings: [String: NSObject] = [:]
        sslSettings[kCFStreamSSLCertificates as String] = clientCertArray
        
        mqtt!.sslSettings = sslSettings
    }
    
    func disconnect(){
        mqtt!.disconnect()
    }
    
    func getClientCertFromP12File(certName: String, certPassword: String) -> CFArray? {
        // get p12 file path
        let resourcePath = Bundle.main.path(forResource: certName, ofType: "p12")
        
        guard let filePath = resourcePath, let p12Data = NSData(contentsOfFile: filePath) else {
            print("Failed to open the certificate file: \(certName).p12")
            return nil
        }
        
        // create key dictionary for reading p12 file
        let key = kSecImportExportPassphrase as String
        let options : NSDictionary = [key: certPassword]
        
        var items : CFArray?
        let securityError = SecPKCS12Import(p12Data, options, &items)
        
        guard securityError == errSecSuccess else {
            if securityError == errSecAuthFailed {
                print("ERROR: SecPKCS12Import returned errSecAuthFailed. Incorrect password?")
            } else {
                print("Failed to open the certificate file: \(certName).p12")
            }
            return nil
        }
        
        guard let theArray = items, CFArrayGetCount(theArray) > 0 else {
            return nil
        }
        
        let dictionary = (theArray as NSArray).object(at: 0)
        guard let identity = (dictionary as AnyObject).value(forKey: kSecImportItemIdentity as String) else {
            return nil
        }
        let certArray = [identity] as CFArray
        
        return certArray
    }
    
    
    func conect(username: String, password: String){
        mqtt?.username = username
        mqtt?.password = password
        
        topics.removeAll()
        topics.append(username)
        topics.append("room/chat")
        mqtt?.connect()
    }
    
    func publish(topic: String, message: String) {
        mqtt?.publish(topic, withString: message, qos: .qos1)
    }
    
//    func publish(topic: String, message: ChatMessage){
//        mqtt?.publish(topic, withString: message, qos: .qos1)
//    }

    fileprivate func subscribe() {
        for topic in topics {
            mqtt?.subscribe(topic, qos: .qos1)
        }
    }
    
}

extension MQTTService: CocoaMQTTDelegate{
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("didConnect \(host):\(port)")
        
        subscribe()
        
    }
    
    // MARK: - CocoaMQTT Delegate
    // Optional ssl CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("didConnectAck: \(ack)，rawValue: \(ack.rawValue)")
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didPublishMessage with message: \(message.string)")
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification" + topics[1])
        NotificationCenter.default.post(name: name, object: self, userInfo: ["message": message.string!, "topic": message.topic])

    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("didPublishAck with id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("didReceivedMessage: \(message.string) with id \(id)")
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.post(name: name, object: self, userInfo: ["message": message.string!, "topic": message.topic])
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("didSubscribeTopic to \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("didUnsubscribeTopic to \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("didPing")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        _console("didReceivePong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        if let error = err {
            print(error)
        }
        _console("mqttDidDisconnect error:")
    }
    
    func _console(_ info: String) {
        print("Delegate: \(info)")
    }
}
