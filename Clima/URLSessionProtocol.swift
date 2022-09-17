//
//  URLSessionProtocol.swift
//  Clima
//
//  Created by Trinh Tran on 16.9.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

public protocol URLSessionDataTaskProtocol {
  func resume()
}

public protocol URLSessionProtocol {
  func dataTask(
    with url: URL,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionDataTaskProtocol
}

extension URLSession : URLSessionProtocol {
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task: URLSessionDataTask = dataTask(with: url, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            completionHandler(data,response,error) }) as URLSessionDataTask
        return task
    }
}

extension URLSessionDataTask : URLSessionDataTaskProtocol {}




