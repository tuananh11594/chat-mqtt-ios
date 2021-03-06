//
// FindUserResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class FindUserResponse: JSONEncodable {
    public var success: Bool?
    public var message: String?
    public var users: [String]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["success"] = self.success
        nillableDictionary["message"] = self.message
        nillableDictionary["users"] = self.users?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
