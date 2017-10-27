//
//  String+Util.swift
//  HXUtils
//
//  Created by hoomsun on 2017/7/5.
//  Copyright © 2017年 hoomsun. All rights reserved.
//

import Foundation
import UIKit

//protocol OptionalString {}
//extension String: OptionalString {}

extension String {
    
    public static func isBlank(_ str: String?) -> Bool {
        guard let str = str else { return true }
        
        if str.trimmingCharacters(in: CharacterSet.whitespaces).characters.count == 0 {
            return true
        }
        
        return false
    }
    
    public static func trimBlankSpace(for str: String?) -> String? {
        guard let str = str else { return nil }
        let resultStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return resultStr
    }
    
    
    /// 检查手机号
    public func isValidMobileNumber() -> Bool {
        let mobileRegex = "1[0-9]{10}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return predicate.evaluate(with:self)
    }
    
    /// 检查固定电话区号
    public func isValidAreaTelephoneNumber() -> Bool {
        let telRegex = "[0]([0-9]{2,3})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", telRegex)
        return predicate.evaluate(with:self)
    }
    
    /// 检查固定电话
    public func isValidTelephoneNumber() -> Bool {
        let telRegex = "^[1-9]\\d{6,7}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", telRegex)
        return predicate.evaluate(with:self)
    }
    
    /// 检查包含区号的完整的固定电话号码
    public func isValidEntireTelephoneNumber() -> Bool {
        let telRegex = "^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", telRegex)
        return predicate.evaluate(with:self)
    }
    
    /// 检查数字及位数（比如，验证码、支付密码等）
    public func isVerifyCode(withQuantity digitQuantity: Int) -> Bool {
        let regex = "^\\d{" + String(digitQuantity) + "}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result: Bool? = predicate.evaluate(with:self)
        
        return result ?? false
    }
    
    /// 计算字符数量（除空格）
    public func countWord() -> Int {
        var l = 0, a = 0
        let n = self.characters.count
        var c: unichar
        
        for i in 0..<n {
            c = (self as NSString).character(at: i)
            if isblank(Int32(c)) != Int32(1) && c != 13 && c != 10 {
                if isascii(Int32(c)) == Int32(1) && c < 65 && c > 122 {
                    a += 1
                } else {
                    l += 1
                }
            }
        }
        
        if a == 0 && l == 0 { return 0 }

        return l + Int(ceil(Double(a)/2.0))
    }
    
    /// 检查身份证
    public func isIdCard() -> Bool {
        let length: Int
        length = self.characters.count
        
        if length != 15 && length != 18 {
            return false
        }
        
        let areasArray = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
        let index = self.index(self.startIndex, offsetBy: 2)
        
        let valueStart2 = self.substring(to: index)
        var areaFlag = false
        
        for areaCode in areasArray {
            if areaCode == valueStart2 {
                areaFlag = true
                break
            }
        }

        if !areaFlag {
            return false
        }
        
        let regex: NSRegularExpression
        var numberOfMatch: Int = 0
        var year: Int? = 0
        
        if length == 15 {
            let start = self.index(self.startIndex, offsetBy: 6)
            let end = self.index(self.startIndex, offsetBy: 8)
            let range = start..<end
            year = Int(self.substring(with: range))
            
            guard var year = year else { return false }
            year += 1900
            
            // 测试出生日期的合法性
            if year%4 == 0 || (year%100 == 0 || year%4==0) {
                let pattern = "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            } else {
                let pattern = "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                regex = try!NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            }
            numberOfMatch = regex.numberOfMatches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count))
            
            if numberOfMatch > 0 {
                return true
            } else {
                return false
            }
        }
        
        if length == 18 {
            let start = self.index(self.startIndex, offsetBy: 6)
            let end = self.index(self.endIndex, offsetBy: -8)
            let range = start..<end
            year = Int(self.substring(with: range))
            
            guard let year = year else { return false }
            
            // 测试出生日期的合法性
            if year%4 == 0 || (year%100 == 0 || year%4==0){
                let pattern = "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            } else {
                let pattern = "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            }
            
            numberOfMatch = regex.numberOfMatches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count))
            
            if numberOfMatch > 0 {
                // 计算校验码
                var sum: Int = 0
                for i in 0..<17 {
                    let start = self.index(self.startIndex, offsetBy: i)
                    let end = self.index(self.startIndex, offsetBy: i+1)
                    let range = start..<end
                    let m = Int(self.substring(with: range))!
                    sum += ((1<<(18-i-1))%11) * m
                }
                var n: Int = 0
                n = (12 - (sum % 11)) % 11
                
                //判断校验码是否跟最后一位数字或字母相符
                let start = self.index(self.startIndex, offsetBy: 17)
                let end = self.index(self.endIndex, offsetBy: 0)
                let range = start..<end
                
                let lastCharacter = self.substring(with: range)
                let isCharacter: Bool = (lastCharacter == "X") || (lastCharacter == "x")
                if !isCharacter {
                    let lastInt: Int = Int(self.substring(with: range))!
                    if (n < 10) && (n == lastInt) {
                        return true
                    } else {
                        return false
                    }
                } else if n == 10 {
                    return true
                } else  {
                    return false
                }
            } else {
                return false
            }
        }
        return false
    }
}



// MARK: -
extension String {
    /// 将AttributedString样式分为2种，前后一致，中间不同
    fileprivate func attributed(from fromIndex: Int, to toIndex: Int, size: CGFloat, otherSize: CGFloat, color: UIColor, otherColor: UIColor) -> NSMutableAttributedString? {
        
        assert(fromIndex <= toIndex, "请确保fromIndex ≤ toIndex")
        guard fromIndex <= toIndex else {
            return nil
        }
        
        let length: Int = self.characters.count
        guard length > 0 else {
            return nil
        }
        
        let mutStr = NSMutableAttributedString(string: self, attributes: nil)
        var range: NSRange
        
        // 改变前1/3部分
        if fromIndex != 0 {
            range = NSMakeRange(0, fromIndex)
            mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: otherSize)], range: range)
            mutStr.addAttributes([NSForegroundColorAttributeName: otherColor], range: range)
        }
        
        // 改变中间部分
        range = NSMakeRange(fromIndex, toIndex - fromIndex + 1)
        mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: size)], range: range)
        mutStr.addAttributes([NSForegroundColorAttributeName: color], range: range)
        
        // 改变后1/3部分
        if toIndex != (length-1) {
            range = NSMakeRange(toIndex + 1, length - 1 - toIndex)
            mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: otherSize)], range: range)
            mutStr.addAttributes([NSForegroundColorAttributeName: otherColor], range: range)
        }
        return mutStr
    }
    
    /// 将AttributedString样式分为3种，前中后都不同
    fileprivate func attributed(from fromIndex: Int, to toIndex: Int, frontSize: CGFloat, midSize:CGFloat, endSize: CGFloat, frontColor: UIColor, midColor: UIColor, endColor: UIColor) -> NSMutableAttributedString? {
        
        assert(fromIndex <= toIndex, "请确保fromIndex ≤ toIndex")
        guard fromIndex <= toIndex else {
            return nil
        }
        
        let length: Int = self.characters.count
        guard length > 0 else {
            return nil
        }
        
        let mutStr = NSMutableAttributedString(string: self, attributes: nil)
        var range: NSRange
        
        // 改变前1/3部分
        if fromIndex != 0 {
            range = NSMakeRange(0, fromIndex)
            mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: frontSize)], range: range)
            mutStr.addAttributes([NSForegroundColorAttributeName: frontColor], range: range)
        }
        
        // 改变中间部分
        range = NSMakeRange(fromIndex, toIndex - fromIndex + 1)
        mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: midSize)], range: range)
        mutStr.addAttributes([NSForegroundColorAttributeName: midColor], range: range)
        
        // 改变后1/3部分
        if toIndex != (length-1) {
            range = NSMakeRange(toIndex + 1, length - 1 - toIndex)
            mutStr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: endSize)], range: range)
            mutStr.addAttributes([NSForegroundColorAttributeName: endColor], range: range)
        }
        return mutStr
    }
}




// MARK: - Func
extension String {
    subscript(i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
}
