//
//  Food.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/3.
//

import Foundation


struct Food:Equatable {
    var name:String
    var image:String
    //热量
    @Suffix("大卡") var calorie:Double = .zero
    //碳水
    @Suffix("g") var carb:Double = .zero
    //脂肪
    @Suffix("g") var fat:Double = .zero
    //蛋白质
    @Suffix("g") var protein:Double = .zero
    
    static let examples=[
        Food(name: "热狗", image: "🌭", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "棒骨", image: "🍖", calorie: 16, carb: 22, fat: 25, protein: 22),
        Food(name: "汉堡", image: "🍔☕️", calorie: 14, carb: 33, fat: 22, protein: 45),
        Food(name: "意大利面", image: "🍝", calorie: 15, carb: 34, fat: 43, protein: 52),
        Food(name: "蔬菜沙拉", image: "🍽️🥗", calorie: 16, carb: 53, fat: 54, protein: 55),
        Food(name: "油焖大虾", image: "🍤", calorie: 17, carb: 43, fat: 42, protein: 41),
        Food(name: "饺子", image: "🥟🫖", calorie: 18, carb: 33, fat: 34, protein: 35)
    ]
    
    
}
