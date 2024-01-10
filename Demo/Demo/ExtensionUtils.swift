//
//  ExtensionUtils.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/8.
//

import SwiftUI

/**
    适配器需要用func    如：extension view
    适配器中的参数，根据协议类型，分别用静态属性表示   如：extension Animation
 */
extension View {
    func setButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }
    
    //some ShapeStyle 类似泛型
    /**
         另一种写法：   func  setFunction<T:ShapeStyle>   ( param : T )  -> some View {}
     */
    func setRoundedRectBackGround(radius: CGFloat = 8,
                              fill:some ShapeStyle = Color.bg) -> some View {
        background(RoundedRectangle(cornerRadius: radius)
            .foregroundStyle(fill))
    }
}

extension Animation{
    static let mySpring = Animation.spring(dampingFraction: 0.5)
    static let myeaseInOut = Animation.easeInOut(duration: 0.5)
}

extension ShapeStyle where Self == Color {
    static var bg : Color { Color(.systemBackground)}
    static var bg2 :  Color { Color(.secondarySystemBackground)}
    static var groupBG :  Color { Color(.systemGroupedBackground)}
}

extension AnyTransition{
    static let delayInsertionOpacity = AnyTransition.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity.animation(.easeInOut(duration: 0.4)))
    
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
}
