//
//  GetLambdaRequest.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/3/21.
//

import Foundation

class GetLambdaRequest: APIRequest {
    var method = RequestType.GET
    var path = URLs.lambdaPath
    var parameters = [String: String]()

    init(name: String) {
        parameters["name"] = name
    }
}
