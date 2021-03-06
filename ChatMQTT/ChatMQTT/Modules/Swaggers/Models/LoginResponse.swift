//
// LoginResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class LoginResponse: JSONEncodable {
    public var success: Bool?
    public var message: String?
    public var token: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["success"] = self.success
        nillableDictionary["message"] = self.message
        nillableDictionary["token"] = self.token
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
