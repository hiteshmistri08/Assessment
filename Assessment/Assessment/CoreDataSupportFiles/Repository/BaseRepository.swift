//
//  BaseRepository.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation

protocol BaseRepository {
    associatedtype T
    func create(_ record:T) -> Bool
    func getAll() -> [T]?
    func get(by id:Int) -> T?
    func update(_ record:T) -> Bool
    func delete(_ id:Int) -> Bool
}
