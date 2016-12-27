//
//  MRTData.swift
//  Specs
//
//  Created by Ping-Ying Yen on 2016/12/24.
//  Copyright © 2016年 Ping-Ying Yen. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataSource {  // A collection of lines
    let lines: [Line]
}
struct Line {  // Each lines has a collection of stations //  table view sections
    let name: String  // like "文湖線"
    let stations: [Station]
}
struct Station { // as table view rows
    var name: String?  // like "大安"
    var lines: [String : String]?  // like ["淡水信義線": "R05", "文湖線": "BR09"]
}

extension Station: Mappable{
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        name <- map["name"]
        lines <- map["lines"]
    }
}

class MRTDataManager {
    var stations: [Station] = []
    var lines: [String] = []
    var dicMRTMapper:[String:Array<Station>] = [:]
    
     func readSourceData() -> Dictionary<String,Array<Station>> {
        let mrtJSONPath = Bundle.main.path(forResource: "MRT", ofType: "json")!
        let mrtJSON = try! String(contentsOfFile : mrtJSONPath)
        stations = Mapper<Station>().mapArray(JSONString: mrtJSON)!
        
        for mrtStation in stations {
            
            let lineSet = Array(mrtStation.lines!.keys)[0]
            if !(lines.contains(lineSet)) {
                // Create an array to put station by line name
                lines.append(lineSet)
            }
        }
        
        for line in lines {
            dicMRTMapper[line] = []
            
            for station in stations {
                let lineNames = Array(station.lines!.keys)
                if lineNames.contains(line) {
                    dicMRTMapper[line]?.append(station)
                }
            }
        }
        return dicMRTMapper
    }
}
