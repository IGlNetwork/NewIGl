//
//  Constant.swift
//  My ID
//
//  Created by Hitaishin on 05/08/16.
//  Copyright © 2016 Harish Patel. All rights reserved.
//

import UIKit

struct GlobalConstant
{
    // MARK: -  APP Name and Url

    
    static let APP_NAME                                  = "IGL"
    

    static let Default_URL                               = "http://iglnetwork.com/api-V1/"
   // static let Default_URL                               = "http://iglnetwork.com/beta/api-V1/"
    
    static let APIKey                                    = ""
    static let GoogleAPIKey                              = ""
   
    static let login                                     = "login"                                     // 01
    static let register                                  = "register"                                  // 02
    static let forget_password                           =  "forget_password"                          // 03
    static let reset_password                            = "reset_password"                            // 04
    static let get_games                                 = "get_games"                                 // 05
    static let gamedetails                               = "gamedetails"                               // 06
    static let gamelike                                  = "gamelike"                                  // 07
    static let addgametoprofile                          = "addgametoprofile"                          // 08
    static let get_gamesupcomingtournaments              = "get_gamesupcomingtournaments"              // 09
    static let get_platforms                             = "get_platforms"                             // 10
    static let get_tournamentlist                        = "get_tournamentlist"                        // 11
    static let get_battleroylaelist                      = "get_battleroylaelist"                      // 12
    static let tournamentdetails                         = "tournamentdetails"                         // 13
    static let checkjoin                                 = "checkjoin"                                 // 14
    //    ==============================
    static let follow_tournament                         = "follow_tournament"                         // 15
    static let tournamentfeeds                           = "tournamentfeeds"                           // 16
    static let userteams                                 = "userteams"                                 // 17
    static let join_tournament                           = "join_tournament"                           // 18
    static let tournament_brackets                       = "tournament_brackets"                       // 19
    static let get_events                                = "get_events"                                // 20
    static let eventdetails                              = "eventdetails"                              // 21
    static let profile                                   = "profile"                                   // 22
    static let get_personlinfo                           = "get_personlinfo"                           // 23
    static let edit_personlinfo                          = "edit_personlinfo"                          // 24
    static let usergames                                 = "usergames"                                 // 25
    static let usertournaments                           = "usertournaments"                           // 26
    static let get_newslist                              =  "get_newslist"                             // 27
    static let newsdetails                               =  "newsdetails"                              // 28
    static let newslike                                  = "newslike"                                  // 29
    static let get_newslikememberlist                    = "get_newslikememberlist"                    // 30
    static let get_newscomments                          = "get_newscomments"                          // 31
    static let comment_news                              = "comment_news"                              // 32
    static let get_challengegames                        = "get_challengegames"                        // 33
    static let get_usergameteams                         =  "get_usergameteams"                        // 34
    static let get_challengergameteams                   =  "get_challengergameteams"                  // 35
    static let submit_challenge                          = "submit_challenge"                          // 36
    static let challenge_made                            =  "challenge_made"                           // 37
    static let challenge_recieved                        = "challenge_recieved"                        // 38
    static let update_challenge                          = "update_challenge"                          // 39
    static let acceptloss                                = "acceptloss"                                // 40
    static let challenge_details                         = "challenge_details"                         // 41
    static let submit_challenge_result                   = "submit_challenge_result"                   // 42
    static let checkin_tournament                        = "checkin_tournament"                        // 43
    static let tournamentjointeams                       =  "tournamentjointeams"                      // 44
    static let tournamentsumit_details                   =  "tournamentsumit_details"                  // 45
    static let tournamentsubmitresult                    =  "tournamentsubmitresult"                   // 46
    static let update_coverpic                           = "update_coverpic"                           // 47
    static let update_profilepic                         = "update_profilepic"                         // 48
    static let tournamentcheckinteams                    = "tournamentcheckinteams"                    // 49
    static let change_password                           = "change_password"                           // 50
    static let contactus                                 = "contactus"                                 // 51
    static let get_tvlist                                = "get_tvlist"                                // 52
    static let tvdetails                                 = "tvdetails"                                 // 53
    static let comment_tv                                =  "comment_tv"                               // 54
    static let get_tvcomments                            = "get_tvcomments"                            // 55
    static let tvlike                                    = "tvlike"                                    // 56
    static let gameusers                                 = "gameusers"                                 // 57
    static let create_team                               = "create_team"                               // 58
    static let get_tournamentwinners                     = "get_tournamentwinners"                     // 59
    static let get_pasttournamentlist                    = "get_pasttournamentlist"                    // 60
    static let get_pastbattleroyalelist                  = "get_pastbattleroyalelist"                  // 61
    static let get_pages_About                           = "get_pages"                                 // 62
    static let get_credits                               = "get_credits"                               // 63
    static let get_leaderboard                           = "get_leaderboard"                           // 64
    static let get_cities                                =   "get_cities"                              // 65
    static let get_trophies                              = "get_trophies"                              // 66
    static let get_favoriteteams                         =   "get_favoriteteams"                       // 67
    static let userprofileteams                          = "userprofileteams"                          // 68
    
    static let get_achievments                           =  "get_achievments"                          // 69
    static let get_eventcategories                       = "get_eventcategories"                       // 70
    static let eventusergoinnotgoing                     = "eventusergoinnotgoing"                     // 71
   
    // 28 May 2019
    static let globalsearch                              = "globalsearch"                               // 72
    
    static let get_notifications                         = "get_notifications"                          // 73
    static let readunread                                = "readunread"                                 // 74
    static let get_tvlikememberlist                      = "get_tvlikememberlist"                       // 75
    static let get_gamelikememberlist                    = "get_gamelikememberlist"                     // 76
    static let maketeamfavarite                          = "maketeamfavarite"                           // 77
    static let get_teammemberlist                        = "get_teammemberlist"                         // 78
    static let teamdetails                               = "teamdetails"                                // 79
    
    static let cahllenge_winner                          = "cahllenge_winner"                           // 80
    static let teamresult                                = "teamresult"                                 // 81
    static let get_allgamestournaments                   = "get_allgamestournaments"                    // 82
    static let get_allgamechallenge                      =  "get_allgamechallenge"                      // 83
    static let get_allgameteams                          = "get_allgameteams"                           // 84
    
    
}

