//
//  ApiClient.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/2/21.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    private let baseURL = URL(string: URLs.baseUrl)!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
            .map {
                try JSONDecoder().decode(T.self, from: $0)
            }
    }
}
