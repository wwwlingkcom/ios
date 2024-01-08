//
//  SuffixWrapper.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/8.
//

/**
    属性封装：
        例子：对Food结构体中的double类型的字段，转换为string
            封装前：Text("热量: \(selectFood!.calorie.formatted()) 大卡")
            封装后：Text("热量: \(selectFood!.$calorie) ")
 */
@propertyWrapper struct Suffix : Equatable{
    //固定的参数名，被包装的数据类型
    var wrappedValue : Double
    //需要传参的情况： 代表一个参数
    private let suffix: String
    
    //初始化： 第二参数前面加_ 变成内置参数（传参时不用写参数名）
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    //让属性 通过$calorie 可以直接获取值
    var projectedValue : String {
        wrappedValue.formatted() + "\(suffix)"
    }
}

