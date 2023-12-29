//
//  ContentView.swift
//  Demo
//
//  Created by 木丁西 on 2023/12/29.
//

import SwiftUI

struct ContentView: View {
    let foodList = ["面条","米饭","葫芦头"]
    @State private var selectFood:String?
    var body: some View {
        VStack (spacing: 20){
            //
            //            Image(systemName: "globe")
            //                    .imageScale(.large)
            //                .foregroundColor(.accentColor)
            Image("eat")
                .resizable()
                .aspectRatio(contentMode: .fit)
        
                
            Text("今天吃啥？")
                .bold()
            
            if selectFood != .none{
                Text(selectFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .id(selectFood)
                    .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity.animation(.easeInOut(duration: 0.4))))
            }
           
            Button(role: .none){
                selectFood = foodList.shuffled().filter{$0 != selectFood}.first
            } label: {
                Text(selectFood == .none ? "告诉我" : "换一个").frame(width: 100)
                //文字变化需要单独设定
                    .transformEffect(.identity)
                //文字关闭动画
                    .animation(.none, value: selectFood)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom,-10)
            
            
            Button(role: .none){
                selectFood = .none
            } label: {
                Text("重置").frame(width: 100)
            }
            .buttonStyle(.bordered)
            
        }
        /**
          .font()  设置vstack中所有的text的字体大小，
            有个特殊点：vstack中有text设置过字体大小的话，此设置不会覆盖之前的，即保持里面的设置大小
         */
        .font(.title2)
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .animation(.easeInOut(duration: 0.5), value: selectFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
