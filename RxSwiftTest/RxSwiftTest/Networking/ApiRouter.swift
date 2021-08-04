//
//  ApiRouter.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/2/21.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    case getLambda(userId: Int)
    case postLambda(userId: Int)

    func asURLRequest() throws -> URLRequest {
        let url = try URLs.baseUrl.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        //Http method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(URLs.ContentType.json.rawValue, forHTTPHeaderField: URLs.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(URLs.ContentType.json.rawValue, forHTTPHeaderField: URLs.HttpHeaderField.contentType.rawValue)

        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: parameters)
    }

    private var method: HTTPMethod {
        switch self {
        case .getLambda:
            return .get
        case .postLambda:
            return .post
        }
    }

    private var path: String {
        switch self {
        case .getLambda:
            return URLs.lambdaPath
        case .postLambda:
            return URLs.lambdaPath
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getLambda(let userId):
            return [URLs.Parameters.userId : userId]
        case .postLambda(let userId):
            return [URLs.Parameters.userId : userId]
        }
    }
}
