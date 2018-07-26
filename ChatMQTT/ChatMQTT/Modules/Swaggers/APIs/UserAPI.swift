//
// UserAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import AlamofireDomain



open class UserAPI: APIBase {
    /**

     - parameter username: (form)  
     - parameter password: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func loginPost(username: String, password: String, completion: @escaping ((_ data: LoginResponse?,_ error: Error?) -> Void)) {
        loginPostWithRequestBuilder(username: username, password: password).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /login
     - Login to system
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou",
  "token" : "aeiou"
}}]
     
     - parameter username: (form)  
     - parameter password: (form)  

     - returns: RequestBuilder<LoginResponse> 
     */
    open class func loginPostWithRequestBuilder(username: String, password: String) -> RequestBuilder<LoginResponse> {
        let path = "/login"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "username": username,
            "password": password
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<LoginResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter username: (form)  
     - parameter password: (form)  
     - parameter confirmPassword: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func registerPost(username: String, password: String, confirmPassword: String, completion: @escaping ((_ data: GeneralResponse?,_ error: Error?) -> Void)) {
        registerPostWithRequestBuilder(username: username, password: password, confirmPassword: confirmPassword).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /register
     - Register a new account
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou"
}}]
     
     - parameter username: (form)  
     - parameter password: (form)  
     - parameter confirmPassword: (form)  

     - returns: RequestBuilder<GeneralResponse> 
     */
    open class func registerPostWithRequestBuilder(username: String, password: String, confirmPassword: String) -> RequestBuilder<GeneralResponse> {
        let path = "/register"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "username": username,
            "password": password,
            "confirmPassword": confirmPassword
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GeneralResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func statsClientsGet(completion: @escaping ((_ data: OnlineClientListResponse?,_ error: Error?) -> Void)) {
        statsClientsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /stats/clients
     - examples: [{contentType=application/json, example={
  "clients" : [ "aeiou" ],
  "success" : true,
  "message" : "aeiou"
}}]

     - returns: RequestBuilder<OnlineClientListResponse> 
     */
    open class func statsClientsGetWithRequestBuilder() -> RequestBuilder<OnlineClientListResponse> {
        let path = "/stats/clients"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<OnlineClientListResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**

     - parameter token: (form)  
     - parameter friend: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersAddFriendPost(token: String, friend: String, completion: @escaping ((_ data: GeneralResponse?,_ error: Error?) -> Void)) {
        usersAddFriendPostWithRequestBuilder(token: token, friend: friend).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /users/add_friend
     - Add friend
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou"
}}]
     
     - parameter token: (form)  
     - parameter friend: (form)  

     - returns: RequestBuilder<GeneralResponse> 
     */
    open class func usersAddFriendPostWithRequestBuilder(token: String, friend: String) -> RequestBuilder<GeneralResponse> {
        let path = "/users/add_friend"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token,
            "friend": friend
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GeneralResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (form)  
     - parameter oldPassword: (form)  
     - parameter newPassword: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersChangePasswordPost(token: String, oldPassword: String, newPassword: String, completion: @escaping ((_ data: GeneralResponse?,_ error: Error?) -> Void)) {
        usersChangePasswordPostWithRequestBuilder(token: token, oldPassword: oldPassword, newPassword: newPassword).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /users/change_password
     - Change account password
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou"
}}]
     
     - parameter token: (form)  
     - parameter oldPassword: (form)  
     - parameter newPassword: (form)  

     - returns: RequestBuilder<GeneralResponse> 
     */
    open class func usersChangePasswordPostWithRequestBuilder(token: String, oldPassword: String, newPassword: String) -> RequestBuilder<GeneralResponse> {
        let path = "/users/change_password"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token,
            "oldPassword": oldPassword,
            "newPassword": newPassword
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GeneralResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (query)  
     - parameter filter: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersFindUserGet(token: String, filter: String, completion: @escaping ((_ data: FindUserResponse?,_ error: Error?) -> Void)) {
        usersFindUserGetWithRequestBuilder(token: token, filter: filter).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /users/find_user
     - Find users in directory
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou",
  "users" : [ "aeiou" ]
}}]
     
     - parameter token: (query)  
     - parameter filter: (query)  

     - returns: RequestBuilder<FindUserResponse> 
     */
    open class func usersFindUserGetWithRequestBuilder(token: String, filter: String) -> RequestBuilder<FindUserResponse> {
        let path = "/users/find_user"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token,
            "filter": filter
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<FindUserResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersListFriendGet(token: String, completion: @escaping ((_ data: ListFriendResponse?,_ error: Error?) -> Void)) {
        usersListFriendGetWithRequestBuilder(token: token).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /users/list_friend
     - List online friends
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou",
  "friends" : [ {
    "id" : "aeiou",
    "presence" : ""
  } ]
}}]
     
     - parameter token: (query)  

     - returns: RequestBuilder<ListFriendResponse> 
     */
    open class func usersListFriendGetWithRequestBuilder(token: String) -> RequestBuilder<ListFriendResponse> {
        let path = "/users/list_friend"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<ListFriendResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (form)  
     - parameter confirmPassword: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersTerminatePost(token: String, confirmPassword: String, completion: @escaping ((_ data: GeneralResponse?,_ error: Error?) -> Void)) {
        usersTerminatePostWithRequestBuilder(token: token, confirmPassword: confirmPassword).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /users/terminate
     - Delete account
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou"
}}]
     
     - parameter token: (form)  
     - parameter confirmPassword: (form)  

     - returns: RequestBuilder<GeneralResponse> 
     */
    open class func usersTerminatePostWithRequestBuilder(token: String, confirmPassword: String) -> RequestBuilder<GeneralResponse> {
        let path = "/users/terminate"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token,
            "confirmPassword": confirmPassword
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GeneralResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersTopicsGet(token: String, completion: @escaping ((_ data: UserTopicListResponse?,_ error: Error?) -> Void)) {
        usersTopicsGetWithRequestBuilder(token: token).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /users/topics
     - Get list of topics created by users
     - examples: [{contentType=application/json, example={
  "success" : true,
  "topics" : [ "aeiou" ],
  "message" : "aeiou"
}}]
     
     - parameter token: (query)  

     - returns: RequestBuilder<UserTopicListResponse> 
     */
    open class func usersTopicsGetWithRequestBuilder(token: String) -> RequestBuilder<UserTopicListResponse> {
        let path = "/users/topics"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<UserTopicListResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**

     - parameter token: (form)  
     - parameter friend: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func usersUnfriendPost(token: String, friend: String, completion: @escaping ((_ data: GeneralResponse?,_ error: Error?) -> Void)) {
        usersUnfriendPostWithRequestBuilder(token: token, friend: friend).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /users/unfriend
     - Remove friend
     - examples: [{contentType=application/json, example={
  "success" : true,
  "message" : "aeiou"
}}]
     
     - parameter token: (form)  
     - parameter friend: (form)  

     - returns: RequestBuilder<GeneralResponse> 
     */
    open class func usersUnfriendPostWithRequestBuilder(token: String, friend: String) -> RequestBuilder<GeneralResponse> {
        let path = "/users/unfriend"
        let URLString = SwaggerClientAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "token": token,
            "friend": friend
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GeneralResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}