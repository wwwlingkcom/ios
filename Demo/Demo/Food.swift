//
//  Food.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/3.
//

import Foundation

struct Food:Equatable{
    var name:String
    var image:String
    var calorie:Double
    var carb:Double
    var fat:Double
    var protein:Double
    
    static let examples=[
        Food(name: "热狗", image: "🌭", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "棒骨", image: "🍖", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "汉堡", image: "🍔☕️", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "意大利面", image: "🍝", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "蔬菜沙拉", image: "🍽️🥗", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "油焖大虾", image: "🍤", calorie: 12, carb: 16, fat: 17, protein: 11),
        Food(name: "饺子", image: "🥟🫖", calorie: 12, carb: 16, fat: 17, protein: 11)
    ]
    
    
}
