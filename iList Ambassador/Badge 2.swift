//
//  Badge.swift
//  iList Ambassador
//
//  Created by Adam Woods on 2017-08-14.
//  Copyright © 2017 iList AB. All rights reserved.
//

// This file was generated by json2swift. https://github.com/ijoshsmith/json2swift

import Foundation

//
// MARK: - Data Model
//
struct Badge: BadgeProtocol { // TODO: Rename this struct
    let brandBadge: BrandBadge
    init(brandBadge: BrandBadge) {
        self.brandBadge = brandBadge
    }
    init?(json: [String: Any]) {
        guard let brandBadge = BrandBadge(json: json, key: "brand_badge") else { return nil }
        self.init(brandBadge: brandBadge)
    }
    struct BrandBadge: BadgeProtocol { // TODO: Rename this struct
        let badge: URL
        let brand: Int
        init(badge: URL, brand: Int) {
            self.badge = badge
            self.brand = brand
        }
        init?(json: [String: Any]) {
            guard let badge = URL(json: json, key: "badge") else { return nil }
            guard let brand = json["brand"] as? Int else { return nil }
            self.init(badge: badge, brand: brand)
        }
    }
}

//
// MARK: - JSON Utilities
//
/// Adopted by a type that can be instantiated from JSON data.
protocol BadgeProtocol {
    /// Attempts to configure a new instance of the conforming type with values from a JSON dictionary.
    init?(json: [String: Any])
}

extension BadgeProtocol {
    /// Attempts to configure a new instance using a JSON dictionary selected by the `key` argument.
    init?(json: [String: Any], key: String) {
        guard let jsonDictionary = json[key] as? [String: Any] else { return nil }
        self.init(json: jsonDictionary)
    }
    
    /// Attempts to produce an array of instances of the conforming type based on an array in the JSON dictionary.
    /// - Returns: `nil` if the JSON array is missing or if there is an invalid/null element in the JSON array.
    static func createRequiredInstances(from json: [String: Any], arrayKey: String) -> [Self]? {
        guard let jsonDictionaries = json[arrayKey] as? [[String: Any]] else { return nil }
        return createRequiredInstances(from: jsonDictionaries)
    }
    
    /// Attempts to produce an array of instances of the conforming type based on an array of JSON dictionaries.
    /// - Returns: `nil` if there is an invalid/null element in the JSON array.
    static func createRequiredInstances(from jsonDictionaries: [[String: Any]]) -> [Self]? {
        var array = [Self]()
        for jsonDictionary in jsonDictionaries {
            guard let instance = Self.init(json: jsonDictionary) else { return nil }
            array.append(instance)
        }
        return array
    }
    
    /// Attempts to produce an array of instances of the conforming type, or `nil`, based on an array in the JSON dictionary.
    /// - Returns: `nil` if the JSON array is missing, or an array with `nil` for each invalid/null element in the JSON array.
    static func createOptionalInstances(from json: [String: Any], arrayKey: String) -> [Self?]? {
        guard let array = json[arrayKey] as? [Any] else { return nil }
        return createOptionalInstances(from: array)
    }
    
    /// Attempts to produce an array of instances of the conforming type, or `nil`, based on an array.
    /// - Returns: An array of instances of the conforming type and `nil` for each invalid/null element in the source array.
    static func createOptionalInstances(from array: [Any]) -> [Self?] {
        return array.map { item in
            if let jsonDictionary = item as? [String: Any] {
                return Self.init(json: jsonDictionary)
            }
            else {
                return nil
            }
        }
    }
}
