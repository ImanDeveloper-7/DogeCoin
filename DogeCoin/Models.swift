//
//  Models.swift
//  DogeCoin
//
//  Created by Iman Zabihi on 20/05/2021.
//

import Foundation

struct APIResponse: Codable {
    let data: [Int: DogeCoineData]
}

struct DogeCoineData: Codable {
    let id: Int
    let name: String
    let symbol: String
    let date_added: String
    let tags: [String]
    let total_supply: Float
    let quote: [String: Quote]
}

struct Quote: Codable {
    let price: Float
    let volume_24h: Float
}

/* {
 "data": {
 "74": {
 "id": 74,
 "name": "Dogecoin",
 "symbol": "DOGE",
 "slug": "dogecoin",
 "num_market_pairs": 361,
 "date_added": "2013-12-15T00:00:00.000Z",
 "tags": [
 ],
 "max_supply": null,
 "circulating_supply": 129666593990.80733,
 "total_supply": 129666593990.80733,
 "is_active": 1,
 "platform": null,
 "cmc_rank": 6,
 "is_fiat": 0,
 "last_updated": "2021-05-20T06:18:03.000Z",
 "quote": {
 "USD": {
 "price": 0.35564796684917,
 "volume_24h": 15236485612.757647,
 "percent_change_1h": 0.02580206,
 "percent_change_24h": -14.6213255,
 "percent_change_7d": -19.83520617,
 "percent_change_30d": -13.6616537,
 "percent_change_60d": 512.08783242,
 "percent_change_90d": 544.75210225,
 "market_cap": 46115660521.08743,
 "last_updated": "2021-05-20T06:18:03.000Z"
 }
 }
 }
 }
 }
 */
