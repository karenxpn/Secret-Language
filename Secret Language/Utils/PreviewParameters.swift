//
//  PreviewParameters.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.07.21.
//

import Foundation
struct PreviewParameters {
    static let birthdayReport = BirthdayReportModel(id: 1, shareId: 1, date_name: "April 21", sln: "sln", sln_description: "sln description", famous_years: "famous years",day_report: DayReportModel(id: 1, day: 21, date_name: "April Twenty-First", day_name: "The Day of Professional Commitment", day_name_short: "The Day of Professional Commitment", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", meditation: "A civilization that regards nuclear energy as important and cooking as trivial is surely headed for destruction", report: "report", numbers: "Those born on th................", health: "April 21.......", advice: "Limit your .....", archetype: "The 21st card...", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"), week_report: WeekReportModel(id: 2, date_span: "Apr. 19-24", name_long: "Week of Power", report: "Report", advice: "Try not to ....",  s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"),month_report: MonthReportModel(id: 3, span1: "April 21—May 21", name: "Nurturer", sign: "Taurus", season: "Initiators", mode: "Sensation", motto: "I Have, ", report: "The Month of the ....", personality: "If Taurus signig.....", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"), season_report: SeasonReportModel(id: 4, name: "Initiation", description: "Initiatiors", span1: "March 21–June 21", season_name: "Spring", activity: "Initiators who begin the whole process; starter-uppers who get things going", report: "The beginning........", faculty: "Intuition", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"), way_report: WayReportModel(id: 78, name: "way report", image: "", week_from: "19 Jun", week_to: "23 Jun", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", report: "report", suggestion: "suggestion", lesson: "lesson", goal: "goal", release: "release", reward: "reward", balance: "balance", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")]), path_report: PathReportModel(id: 88, prefix: "prefix", way_name: "way name", name_long: "name long", name_medium: "name medium", image: "", challenge: "challenge", fulfillment: "fulfillment", report: "report"), relationship_report:  RelationshipReportModel(id: 1, shareId: 1, birthday_1: "19 January", birthday_1_name: "Week of Love", birthday_2: "20 January", birthday_2_name: "Week of friendship", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/rel/150/png/0066.png", name: "Creature comforts", s1: "Aesthetic", s2: "Cultiral", s3: "Secure", w1: "Aesthetic", w2: "Cultural", w3: "Secure", ideal_for: "Family", report: "his relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", problematic_for: "Friendship"))
    
    static let relationshipReport = RelationshipReportModel(id: 1, shareId: 1, birthday_1: "19 January", birthday_1_name: "Week of Love", birthday_2: "20 January", birthday_2_name: "Week of friendship", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/rel/150/png/0066.png", name: "Creature comforts", s1: "Aesthetic", s2: "Cultiral", s3: "Secure", w1: "Aesthetic", w2: "Cultural", w3: "Secure", ideal_for: "Family", report: "his relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", problematic_for: "Friendship")
    
    static let chatList = [ChatModel(id: 1, chatName: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", message: ChatPreveiwMessage(id: 1, type: "text", content: [ContentModel(message: "Shall we meet today?", type: "text")], created_at: "1 year ago"), user: ChatUserModel(id: 20, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business", age: 21), unread_messages_count: "9+", read: false)]
}
