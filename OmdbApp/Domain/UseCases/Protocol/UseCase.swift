//
//  UseCase.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation



public protocol UseCase
{
    @discardableResult
    func start() -> Cancellable?
}
