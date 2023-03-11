//
//  JsonDecoderEncoder+Any.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 08/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}

extension JSONDecoder.DateDecodingStrategy {
//    static let customISO8601 = custom { decoder throws -> Date in
//        let container = try decoder.singleValueContainer()
//        let string = try container.decode(String.self)
//        if let date = Formatter.iso8601.date(from: string) ?? Formatter.iso8601noFS.date(from: string) {
//            return date
//        }
//        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
//    }
}

//extension Formatter {
//    static let iso8601: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.calendar = Calendar(withComponents: .iso8601)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
//        return formatter
//    }()
//
//    static let iso8601noFS: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.calendar = Calendar(withComponents: .iso8601)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
//        return formatter
//    }()
//}

extension Dictionary {
    mutating func unionInPlace(_ dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
    func union(_ dictionary: [Key: Value]) -> [Key: Value] {
        var dict = self
        dict.unionInPlace(dictionary)
        return dict
    }
}
