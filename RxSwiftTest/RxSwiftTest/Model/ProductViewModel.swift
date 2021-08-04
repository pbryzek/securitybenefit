//
//  ProductViewModel.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/2/21.
//

import RxSwift
import Foundation

struct Product {
    let imageName: String
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()

    func fetchItems() {
        let products = [Product(imageName: "house", title:NSLocalizedString("Home", comment: "")),
                        Product(imageName: "gear", title:NSLocalizedString("GET API Call", comment: "")),
                        Product(imageName: "gear", title:NSLocalizedString("POST API Call", comment: "")),
                        Product(imageName: "gear", title:NSLocalizedString("Cancel API Call", comment: ""))]
        items.onNext(products)
        items.onCompleted()
    }
}
