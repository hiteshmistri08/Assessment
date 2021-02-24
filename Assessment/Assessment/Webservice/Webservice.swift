//
//  Webservice.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation

struct Webservice {
    private init() {}
    static func get(url:URL,completion:@escaping(Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
    }
}
