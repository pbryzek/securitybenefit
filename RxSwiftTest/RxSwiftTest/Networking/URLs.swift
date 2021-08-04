//
//  URLs.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/2/21.
//

struct URLs {
    static let https = "https://"
    static let domain = "vbj8146aq0.execute-api.us-east-2.amazonaws.com/default/"
    static let baseUrl = https + domain

    //Paths
    static let lambdaPath = "lambda-microservice"
    static let lambdaUrl = https + domain + lambdaPath



    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum ContentType: String {
        case json = "application/json"
    }

    struct Parameters {
        static let userId = "userId"
    }

    enum ApiError: Error {
        case forbidden              //Status code 403
        case notFound               //Status code 404
        case conflict               //Status code 409
        case internalServerError    //Status code 500
    }
}
