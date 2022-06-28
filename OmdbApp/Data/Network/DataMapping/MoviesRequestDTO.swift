//
//  MoviesRequestDTO.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

struct MoviesRequestDTO : Encodable
{
    let query: String
    let page: Int
}
