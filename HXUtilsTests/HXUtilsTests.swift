//
//  HXUtilsTests.swift
//  HXUtilsTests
//
//  Created by hoomsun on 2017/7/5.
//  Copyright © 2017年 hoomsun. All rights reserved.
//

import XCTest

@testable import HXUtils

class HXUtilsTests: XCTestCase {
    var str: String?
    
    override func setUp() {
        super.setUp()
        str = nil
    }
    
    override func tearDown() {
        str = nil
        super.tearDown()
    }
    
    /// 测试str = nil时是否判断为true
    func testStringIsNil() {
//        XCTAssertTrue((str?.isEmpty)!)
        XCTAssertTrue(String.isBlank(string: str))
    }
    
    /// 测试str的字符数量为0时是否判断为true
    func testStringCountIsZero() {
        str = ""
        XCTAssertTrue(String.isBlank(string: str))
    }
    
    /// 测试str为1个空格时是否判断为true
    func testStringHaveOneBlank() {
        str = " "
        XCTAssertTrue(String.isBlank(string: str))
    }
    
    /// 测试str为多个空格时是否判断为true
    func testStringHaveMoreThanOneBlank() {
        str = "     "
        XCTAssertTrue(String.isBlank(string: str))
    }
    
    /// 测试str为正常字符串时应判断为false
    func testStringisNotBlank() {
        str = "123abc"
        XCTAssertFalse(String.isBlank(string: str))
    }
    
    
    /// 测试清除str中空格和换行
    func testTrimString() {
        str = "abc "
        XCTAssertEqual(String.trimBlankSpace(for: str), "abc")
        
        str = " abc "
        XCTAssertEqual(String.trimBlankSpace(for: str), "abc")
        
        str = "\nabc\n"
        XCTAssertEqual(String.trimBlankSpace(for: str), "abc")
        
        str = "abc,123,)(*_~+"
        XCTAssertEqual(String.trimBlankSpace(for: str), "abc,123,)(*_~+")
        
        str = ""
        XCTAssertEqual(String.trimBlankSpace(for: str), "")
        
        str = nil
        XCTAssertNil(String.trimBlankSpace(for: str))
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}


extension HXUtilsTests {
    /// 检查手机号
    func testMobileValidation() {
        // 手机号有效
        str = "13100009999"
        XCTAssertTrue((str?.isValidMobileNumber())!)
        
        str = "10011112222"
        XCTAssertTrue((str?.isValidMobileNumber())!)
        
        str = "19100009999"
        XCTAssertTrue((str?.isValidMobileNumber())!)
        
        // 手机号无效
        str = "131"
        XCTAssertFalse((str?.isValidMobileNumber())!)
        
        str = "03100000000"
        XCTAssertFalse((str?.isValidMobileNumber())!)
        
        str = "93100000000"
        XCTAssertFalse((str?.isValidMobileNumber())!)
    }
    
    /// 检查固定电话区号
    func testTelephoneAreaNumber() {
        // 区号无效
        str = "0"
        XCTAssertFalse((str?.isValidAreaTelephoneNumber())!)
        
        str = "00"
        XCTAssertFalse((str?.isValidAreaTelephoneNumber())!)
        
        str = "100"
        XCTAssertFalse((str?.isValidAreaTelephoneNumber())!)
        
        str = "00111"
        XCTAssertFalse((str?.isValidAreaTelephoneNumber())!)
        
        // 区号有效
        str = "000"
        XCTAssertTrue((str?.isValidAreaTelephoneNumber())!)
        
        str = "0999"
        XCTAssertTrue((str?.isValidAreaTelephoneNumber())!)
    }
    
    /// 检查固定电话
    func testTelephoneNumber() {
        // 电话无效
        str = "abcdfg12"
        XCTAssertFalse((str?.isValidTelephoneNumber())!)
        
        str = "01234567"
        XCTAssertFalse((str?.isValidTelephoneNumber())!)
        
        // 位数不够7-8位
        str = "100000"
        XCTAssertFalse((str?.isValidTelephoneNumber())!)
        
        str = "123456"
        XCTAssertFalse((str?.isValidTelephoneNumber())!)
        
        // 电话有效
        str = "88889999"
        XCTAssertTrue((str?.isValidTelephoneNumber())!)
    }
    
    /// 检查包含区号的完整的固定电话号码
    func testEntireTelephoneNumber() {
        // 电话无效
        str = "abcdfg12"
        XCTAssertFalse((str?.isValidEntireTelephoneNumber())!)
        
        // 第1位数字不为0 - false
        str = "10011112222"
        XCTAssertFalse((str?.isValidEntireTelephoneNumber())!)
        
        // 区号3位数，固话为7位数 - false
        str = "0101234567"
        XCTAssertFalse((str?.isValidEntireTelephoneNumber())!)
        
        // 区号4位数，固话为6位数 - false
        str = "0154123456"
        XCTAssertFalse((str?.isValidEntireTelephoneNumber())!)
        
        // 区号3位数，固话8位数 - true
        str = "01012345678"
        XCTAssertTrue((str?.isValidEntireTelephoneNumber())!)
        
        // 区号4位数，固话7位数 - true
        str = "01541234567"
        XCTAssertTrue((str?.isValidEntireTelephoneNumber())!)
        
        // 区号4位数，固话8位数 - true
        str = "015412345678"
        XCTAssertTrue((str?.isValidEntireTelephoneNumber())!)
    }
    
    /// 检查验证码及位数
    func testVerifyCode() {
        // 验证码不为数字 - false
        str = "abcdef"
        XCTAssertFalse((str?.isVerifyCode(withQuantity: 6))!)
        
        // 验证码不全为数字 - false
        str = "a1123"
        XCTAssertFalse((str?.isVerifyCode(withQuantity: 6))!)
        
        // 验证码个数为0 - false
        str = " "
        XCTAssertFalse((str?.isVerifyCode(withQuantity: 0))!)
        
        // 验证码个数为1 - false
        str = " "
        XCTAssertFalse((str?.isVerifyCode(withQuantity: 1))!)
        
        // 验证码个数为0 - true
        str = ""
        XCTAssertTrue((str?.isVerifyCode(withQuantity: 0))!)
        
        // 验证码位数 - false
        str = "a1123"
        XCTAssertFalse((str?.isVerifyCode(withQuantity: 5))!)
        
        // 验证码位数 - true
        str = "1234567890"
        XCTAssertTrue((str?.isVerifyCode(withQuantity: 10))!)
    }
    
    /// 计算字符数量（除空格）
    func testCountWord() {
        // 包含空格
        str = "abcdef  "
        XCTAssertEqual(str?.countWord(), 6)
        
        // 正常情况
        str = "abcdef"
        XCTAssertEqual(str?.countWord(), 6)
        
        // 特殊字符
        str = "+-()*&^%$#@!~`<>?,./':[]{}|;"
        XCTAssertEqual(str?.countWord(), 28)
        
        // 换行
        str = "abcd10-7+<@\n"
        XCTAssertEqual(str?.countWord(), 11)
    }
    
    /// 检查身份证
    func testIdCard() {
        
        // 数字个数不够
        str = "6"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 任意字符
        str = "610abc19*(08013116"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 任意字符
        str = "~!@#$%^&*()_+][.|,"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 数字个数不够
        str = "61010219800801311"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610102198407203112"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 正确
        str = "610102198407203116"
        XCTAssertTrue((str?.isIdCard())!)
        
    /* ------------------------------------- */
        // 正确
        str = "61010219550812312x"
        XCTAssertTrue((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098471"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098472"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098473"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098474"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098475"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098476"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098477"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098478"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098479"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 错误的校验码
        str = "610523199106098470"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 测试15位身份证
        str = "610102840720311"
        XCTAssertTrue((str?.isIdCard())!)
        
        // 测试15位身份证
        str = "610102550812312"
        XCTAssertTrue((str?.isIdCard())!)
        
        // 测试15位身份证，错误
        str = "61010255081231&"
        XCTAssertFalse((str?.isIdCard())!)
        
        // 测试15位身份证，错误
        str = "610102**081231&"
        XCTAssertFalse((str?.isIdCard())!)
    }
    
    func testUITableViewCellUtil() {
        let height = HSTableViewCell.viewHeight()
        XCTAssertEqual(height, 80.0)
        
        let height2 = UITableViewCell.viewHeight()
        XCTAssertNil(height2)
    }
}
