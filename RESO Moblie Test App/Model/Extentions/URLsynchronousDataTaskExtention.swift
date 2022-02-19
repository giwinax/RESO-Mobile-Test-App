//
//  URLsynchronousDataTaskExtention.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, Error?) {
        var data: Data?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: url) {
            data = $0
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, error)
    }
}
