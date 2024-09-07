//
//  ProfileDTO.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

// MARK: - ProfileDTO
struct ProfileDTO: Decodable {
    let rtnCode: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Decodable {
    let isJuror, isFounded, guide: Bool
    let characterInfo: CharacterInfo
    let battleInfo: BattleInfo
    let profileInfo: ProfileInfo
    let profileImageInfo: [ProfileImageInfo]
    let sanction: Bool
}

// MARK: - BattleInfo
struct BattleInfo: Decodable {
    let winPer, killDeathPer, arPer, srPer: String
    let clanBreakawayIndex, mercenaryClanBreakawayIndex, mercenaryClanBreakawayIndexStr: String

    enum CodingKeys: String, CodingKey {
        case winPer = "win_per"
        case killDeathPer = "kill_death_per"
        case arPer = "ar_per"
        case srPer = "sr_per"
        case clanBreakawayIndex = "clan_breakaway_index"
        case mercenaryClanBreakawayIndex = "mercenary_clan_breakaway_index"
        case mercenaryClanBreakawayIndexStr = "mercenary_clan_breakaway_index_str"
    }
}

// MARK: - CharacterInfo
struct CharacterInfo: Decodable {
    let userNoOrigin: String
    let userNexonSn: Int
    let userNick: String
    let levelNo: Int
    let seasonLevelJoinFlag: String
    let seasonLevelNo: Int
    let totalLevelImg, levelImg, gradeImg: String
    let rankNo, totalRankNo, userGradeRanking, rankPer: String
    let clanName, clanID: String
    let clanMark1, clanMark2, membershipImg: String
    let membership, vipGradeImg: String
    let vipGrade: Int
    let vipGradeCSS, seasonYear, punishType, punishDate: String
    let officialClan: Int
    let inventoryTag, totalSP: String

    enum CodingKeys: String, CodingKey {
        case userNoOrigin = "user_no_origin"
        case userNexonSn = "user_nexon_sn"
        case userNick = "user_nick"
        case levelNo = "level_no"
        case seasonLevelJoinFlag = "season_level_join_flag"
        case seasonLevelNo = "season_level_no"
        case totalLevelImg = "total_level_img"
        case levelImg = "level_img"
        case gradeImg = "grade_img"
        case rankNo = "rank_no"
        case totalRankNo = "total_rank_no"
        case userGradeRanking = "user_grade_ranking"
        case rankPer = "rank_per"
        case clanName = "clan_name"
        case clanID = "clan_id"
        case clanMark1 = "clan_mark1"
        case clanMark2 = "clan_mark2"
        case membershipImg = "membership_img"
        case membership
        case vipGradeImg = "vip_grade_img"
        case vipGrade = "vip_grade"
        case vipGradeCSS = "vip_grade_css"
        case seasonYear = "season_year"
        case punishType = "punish_type"
        case punishDate = "punish_date"
        case officialClan = "official_clan"
        case inventoryTag = "inventory_tag"
        case totalSP = "total_sp"
    }
}

// MARK: - ProfileInfo
struct ProfileInfo: Decodable {
    let imageNo: String
    let userImg: String
    let userIntro, agreeTag: String
    let isManner: Bool
    let mannerGradeTotal, mannerGradeTotalCSS, mannerGradeTotalTitle, mannerGrade1: String
    let mannerGrade1_Class, mannerGrade2, mannerGrade2_Class, mannerGrade3: String
    let mannerGrade3_Class, mannerGrade4, mannerGrade4_Class, mannerGrade5_Data: String
    let mannerGrade6_Data, mannerGrade6_Grade, mannerPercentileRate: String

    enum CodingKeys: String, CodingKey {
        case imageNo = "image_no"
        case userImg = "user_img"
        case userIntro = "user_intro"
        case agreeTag = "agree_tag"
        case isManner
        case mannerGradeTotal = "manner_grade_total"
        case mannerGradeTotalCSS = "manner_grade_total_css"
        case mannerGradeTotalTitle = "manner_grade_total_title"
        case mannerGrade1 = "manner_grade_1"
        case mannerGrade1_Class = "manner_grade_1_class"
        case mannerGrade2 = "manner_grade_2"
        case mannerGrade2_Class = "manner_grade_2_class"
        case mannerGrade3 = "manner_grade_3"
        case mannerGrade3_Class = "manner_grade_3_class"
        case mannerGrade4 = "manner_grade_4"
        case mannerGrade4_Class = "manner_grade_4_class"
        case mannerGrade5_Data = "manner_grade_5_data"
        case mannerGrade6_Data = "manner_grade_6_data"
        case mannerGrade6_Grade = "manner_grade_6_grade"
        case mannerPercentileRate = "manner_percentile_rate"
    }
}

// MARK: - ProfileImageInfo
struct ProfileImageInfo: Decodable {
    let userImg: String
    let imageNo: String

    enum CodingKeys: String, CodingKey {
        case userImg = "user_img"
        case imageNo = "image_no"
    }
}

// MARK: - ToDomain
extension ProfileDTO {
    func toDomain() -> ProfileResponse {
        .init(
            userName: result.characterInfo.userNick,
            userImage: result.profileImageInfo.first?.userImg ?? ""
        )
    }
}
