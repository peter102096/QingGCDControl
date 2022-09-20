//
//  Global.swift
//  QingGCDControl
//
//  Created by PeterLin on 2022/9/20.
//

import UIKit

public class Global: NSObject {
    public static let DateFormat = "yyyyMMddHHmmss"
    public static let DayFormat:String = "yyyy-MM-dd"
    public static let NonYearFormat:String = "MM-dd HH:mm:ss"
    public static let ExportFormat: String = "yyyy_MM_dd_HHmmss"

    public static let ServerMsFormat:String = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    public static let ServerFormat:String = "yyyy-MM-dd'T'HH:mm:ss"
    
    public static let TimeFormat:String = "HH:mm:ss"
    public static let NonSecTimeFormat:String = "HH:mm"
    
    public static var deviceTimeZone: TimeZone {
        get {
            let localTimeZoneIdentifier = TimeZone.current.identifier
            return TimeZone(identifier: localTimeZoneIdentifier) ?? TimeZone(identifier: "GMT")!
        }
    }
}

