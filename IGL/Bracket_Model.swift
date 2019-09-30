//
//  Bracket_Model.swift
//  IGL
//
//  Created by Mac Min on 22/01/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//
/*

// "Round": 1,
 //"Time": "05:30 AM",
 "Groups": [
 {
// "TournamentGroupID": "41",
 //"TournamentGroupName": "1",
 //"TournamentWinnerGroup": "5",
 //"TournamentGroupTournamentID": "6",
 //"TournamentGroupRoundID": "1",
// "TournamentGroupType": "1",
// "TournamentGroupCreatedAt": "2018-12-31 08:28:09",
 "teams": [
 {
// "TeamID": "12",
// "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/1543649802dota-2-reborn-lag.jpg",
 //"TeamName": "manx99team"
 },
 {
 //"TeamID": "15",
// "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/1543650691dota-2-reborn-lag.jpg",
 "TeamName": "testgamerteam2"
 }
 ]
 },
 
 
 
// "TeamID": "13",
 //"TeamName": "jasonxi",
// "TournamentWinnerPosition": "1",
 "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/1543649990GuidedBotMatches.jpg"
 */
import Foundation
//
//class BracketModel {
//
//    var Round = ""
//    var Time = ""
//    var TournamentGroupID = ""
//    var TournamentGroupName = ""
//    var TournamentWinnerGroup = ""
//    var TournamentGroupTournamentID = ""
//    var TournamentGroupRoundID = ""
//    var TournamentGroupType = ""
//    var TournamentGroupCreatedAt = ""
//    var TeamID1 = ""
//    var TeamImage1 = ""
//    var TeamName1 = ""
//    var TeamID2 = ""
//    var TeamImage2 = ""
//    var TeamName2 = ""
//    var WinnerTeamID = ""
//    var  WinnerTeamName = ""
//    var TournamentWinnerPosition = ""
//    var WinnerTeamImage = ""
//    func toString()-> String{
//        return "BracketModel{Round:"+Round+",Time:"+Time+",TournamentGroupID:"+TournamentGroupID+",TournamentGroupName:"+TournamentGroupName+",TournamentWinnerGroup:"+TournamentWinnerGroup+",TournamentGroupTournamentID:"+TournamentGroupTournamentID+",TournamentGroupRoundID:"+TournamentGroupRoundID+",TournamentGroupType:"+TournamentGroupType+",TournamentGroupCreatedAt:"+TournamentGroupCreatedAt+",TeamID1:"+TeamID1+",TeamImage1:"+TeamImage1+",TeamName1:"+TeamName1+",TeamID2:"+TeamID2+",TeamImage2:"+TeamImage2+",TeamName2:"+TeamName2+",WinnerTeamID:"+WinnerTeamID+",WinnerTeamName:"+WinnerTeamName+",TournamentWinnerPosition:"+TournamentWinnerPosition+",WinnerTeamImage:"+WinnerTeamImage+"}"
//    }
//}


struct BracketModel {
     var TournamentGroupID = ""
     var TournamentGroupName = ""
     var TournamentWinnerGroup = ""
     var TournamentGroupTournamentID = ""
     var TournamentGroupRoundID = ""
     var TournamentGroupType = ""
    var TournamentGroupCreatedAt = ""
    var TeamID1 = ""
    var TeamImage1 = ""
    var TeamName1 = ""
    var TeamID2 = ""
    var TeamImage2 = ""
    var TeamName2 = ""
    var Winner_TeamID = ""
    var Winner_TeamName = ""
    var Winnner_TeamImage   = ""
}

struct FinalBracket {
    var Round = ""
    var Time = ""
    var Group = [BracketModel]()
    var TournamentWinnerPosition = ""
   
}
