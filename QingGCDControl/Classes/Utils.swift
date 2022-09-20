//
//  Extensions.swift
//  QingGCDControl
//
//  Created by PeterLin on 2022/9/20.
//

import UIKit

extension String {
    public var localized:String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func splitPerChar(_ count: Int) -> String {
        let strArray = Array(self)
        var str = ""
        for i in 0..<strArray.count {
            str.append(strArray[i])
            if (i + 1) != strArray.count, (i + 1) % count == 0 {
                str.append(" ")
            }
        }
        return str
    }
    
    public func formatDate(_ type: Date.formatType, timeZone: TimeZone? = TimeZone(secondsFromGMT: 0)) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        switch type {
        case .Date:
            formatter.dateFormat = Global.DateFormat
        case .Day:
            formatter.dateFormat = Global.DayFormat
        case .NonYear:
            formatter.dateFormat = Global.NonYearFormat
        case .Export:
            formatter.dateFormat = Global.ExportFormat
        case .ServerMs:
            formatter.dateFormat = Global.ServerMsFormat
        case .Server:
            formatter.dateFormat = Global.ServerFormat
        case .Time:
            formatter.dateFormat = Global.TimeFormat
        case .NonSecTime:
            formatter.dateFormat = Global.NonSecTimeFormat
        }
        return formatter.date(from: self)
    }
    
    public var macAddrFormat: String {
        let strArray = Array(self)
        var macAddr = ""
        for i in 0..<strArray.count {
            macAddr.append(strArray[i])
            if (i + 1) != strArray.count, (i + 1) % 2 == 0 {
                macAddr.append(":")
            }
        }
        return macAddr
    }
    
    public var hexString: String {
        guard let data = self.data(using: .ascii) else { return "" }
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
    
    public var isHexNumber: Bool {
        filter(\.isHexDigit).count == count
    }
    
    public var asciiString: String {
        if self == "00" { return "" }
        let chars = Array(self)
        
        let numbers = stride(from: 0, to: chars.count, by: 2).map {
            strtoul(String(chars[$0 ..< $0+2]), nil, 16)
        }
        var final = ""
        var i = 0
        
        while i < numbers.count {
            final.append(Character(UnicodeScalar(Int(numbers[i])) ?? " "))
            i += 1
        }
        return final
    }
    
    public var hex2ascii: String {
        let strArray = Array(self)
        var asciiChar = ""
        var asciiStr = ""
        for i in 0..<strArray.count {
            asciiChar.append(strArray[i])
            if (i + 1) % 2 == 0 {
                let ascii = asciiChar.asciiString
                asciiStr.append(ascii)
                asciiChar = ""
            }
        }
        return asciiStr
    }
    
    public func hasFilter(regex: String) -> Bool? {
        do {
            let regexExp = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            if regexExp.firstMatch(in: self, range: range) != nil {
                return true
            } else {
                return false
            }
        } catch {
            print("regex error : \(error.localizedDescription)")
            return nil
        }
    }
    
    public func replace(for regex: String, with replaceWith: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            print("regex error : \(error.localizedDescription)")
            return self
        }
    }
    
    public mutating func insert(string:String,index:Int) {
        self.insert(contentsOf: string, at: self.index(self.startIndex, offsetBy: index))
    }
}

extension Date {
    public enum formatType {
        case Date
        case Day
        case NonYear
        case Export
        case ServerMs
        case Server
        case Time
        case NonSecTime
    }
    
    public func formatStr(_ type: formatType, timeZone: TimeZone? = TimeZone(secondsFromGMT: 0)) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        switch type {
        case .Date:
            formatter.dateFormat = Global.DateFormat
        case .Day:
            formatter.dateFormat = Global.DayFormat
        case .NonYear:
            formatter.dateFormat = Global.NonYearFormat
        case .Export:
            formatter.dateFormat = Global.ExportFormat
        case .ServerMs:
            formatter.dateFormat = Global.ServerMsFormat
        case .Server:
            formatter.dateFormat = Global.ServerFormat
        case .Time:
            formatter.dateFormat = Global.TimeFormat
        case .NonSecTime:
            formatter.dateFormat = Global.NonSecTimeFormat
        }
        let date = formatter.string(from: self)
        return date
    }
    
    public var localTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = Global.deviceTimeZone
        formatter.dateFormat = Global.DateFormat
        let date = formatter.string(from: self)
        return date
    }
    
    public var exportTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = Global.deviceTimeZone
        formatter.dateFormat = Global.ExportFormat
        let date = formatter.string(from: self)
        return date
    }
}

extension TimeInterval {
    public var elapsedTimeAsString: String {
        return String(format: "%02d:%02d'%d", Int(self / 60), Int(self.truncatingRemainder(dividingBy: 60)), Int((self * 10).truncatingRemainder(dividingBy: 10)))
    }
    
    public var seconds: Int {
        return Int(self.rounded())
    }

    public var milliseconds: Int {
        return Int(self * 1_000)
    }
}

extension Locale {
    public static var preferredLanguageCode: String {
        guard let preferredLanguage = preferredLanguages.first,
              let code = Locale(identifier: preferredLanguage).languageCode else {
            return "en"
        }
        return code
    }
    
    public static var preferredLanguageCodes: [String] {
        return Locale.preferredLanguages.compactMap({Locale(identifier: $0).languageCode})
    }
    
    public static var preferredLanguage: String {
        guard let preLau = Locale.preferredLanguages.first else {
            return "en"
        }
        return preLau.replacingOccurrences(of: "-TW", with: "")
    }
}
