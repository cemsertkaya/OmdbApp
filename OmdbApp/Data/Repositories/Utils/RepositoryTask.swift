//
//  RepositoryTask.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
