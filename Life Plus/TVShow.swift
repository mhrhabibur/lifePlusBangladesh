//
//  TVShow.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
    let id: Int?
    let url: String?
    let name, type, language: String?
    let genres: [String]?
    let status: String?
    let runtime, averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let webChannel, dvdCountry: JSONNull?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previousepisode: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String?
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

