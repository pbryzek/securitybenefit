//
//  PostLambdaRequest.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/3/21.
//


import Foundation

class PostLambdaRequest: APIRequest {
    var method = RequestType.POST
    var path = URLs.lambdaPath
    var parameters = [String: String]()

    init(name: String) {
        parameters["name"] = name
    }
}

