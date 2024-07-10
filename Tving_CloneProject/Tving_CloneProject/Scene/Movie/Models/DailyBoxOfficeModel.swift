//
//  DailyBoxOfficeModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import Foundation

struct DailyBoxOfficeModel: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieNm, openDt, salesAmt, salesShare,
             salesInten, salesChange, salesAcc, audiCnt,
             audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}
