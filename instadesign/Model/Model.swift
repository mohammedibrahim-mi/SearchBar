//
//  Model.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

import Foundation

struct CryptoCurrenciesModel: Codable {
    let success: Bool
    let message: String
    let data: [CryptoCurrenciesDatum]
}

struct CryptoCurrenciesDatum: Codable {
    let id: Int
    let name, slug: String
    let url: String
    let logoURL: String
    let networkType: String?
    let customID: Int?
    let buyTrade, sellTrade: Int
    let depositLimit: Double
    let maxDepositLimit, depositFee, withdrawLimit, withdrawPerDay: Int
    let withdrawFee, depositStatus, withdrawStatus, limitStatus: Int
    let makerFee, takerFee, gstFee: Int
    let minTradeLimit: Double
    let maxTradeLimit, marginTransferStatus: Int
    let usd: Double
    let affiliateCommission, iscrypto, status, decimalPoint: Int
    let createdAt: String?
    let updatedAt: String
    let logo: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, url
        case logoURL = "logo_url"
        case networkType = "network_type"
        case customID = "custom_id"
        case buyTrade = "buy_trade"
        case sellTrade = "sell_trade"
        case depositLimit = "deposit_limit"
        case maxDepositLimit = "max_deposit_limit"
        case depositFee = "deposit_fee"
        case withdrawLimit = "withdraw_limit"
        case withdrawPerDay = "withdraw_per_day"
        case withdrawFee = "withdraw_fee"
        case depositStatus = "deposit_status"
        case withdrawStatus = "withdraw_status"
        case limitStatus = "limit_status"
        case makerFee = "maker_fee"
        case takerFee = "taker_fee"
        case gstFee = "gst_fee"
        case minTradeLimit = "min_trade_limit"
        case maxTradeLimit = "max_trade_limit"
        case marginTransferStatus = "margin_transfer_status"
        case usd
        case affiliateCommission = "affiliate_commission"
        case iscrypto, status
        case decimalPoint = "decimal_point"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case logo
    }
}
