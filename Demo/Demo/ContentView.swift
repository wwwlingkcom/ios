//
//  ContentView.swift
//  Demo
//
//  Created by 木丁西 on 2023/12/29.
//

import SwiftUI

struct ContentView: View {
    let foodList = Food.examples
    @State private var selectFood:Food?
    @State private var showFlag:Bool = false
    var body: some View {
        ScrollView{
            VStack (spacing: 20){
                //
                //            Image(systemName: "globe")
                //                    .imageScale(.large)
                //                .foregroundColor(.accentColor)
                Group{
                    if selectFood != .none{
                        Text(selectFood!.image)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                    }else{
                        Image("eat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 250)
                //                .border(.blue)
                
                Text("今天吃啥？")
                    .bold()
                    .font(.largeTitle)
                
                if selectFood != .none{
                    HStack{
                        Text(selectFood!.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                            .id(selectFood!.name)
                            .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity.animation(.easeInOut(duration: 0.4))))
                        Button(){
                            showFlag.toggle()
                        }label: {
                            Image(systemName: "info.circle.fill").foregroundColor(.secondary)
                        }
                        
                    }
                    Text("热量: \(selectFood!.calorie.formatted()) 大卡")
                    
                    //这块添加vstack及它的修饰器，是为了让grid的动画在固定的高度进行，注意：必须要在if之外
                    VStack{
                        if(showFlag){
                            Grid(horizontalSpacing: 12,verticalSpacing: 12){
                                GridRow{
                                    Text("碳水化合物")
                                    Text("脂肪")
                                    Text("蛋白质")
                                }
                                Divider()
                                    .gridCellUnsizedAxes(.horizontal)
                                    .padding(.horizontal,10)
                                GridRow{
                                    Text(selectFood!.carb.formatted() + " g")
                                    Text(selectFood!.fat.formatted() + " g")
                                    Text(selectFood!.protein.formatted() + " g")
                                }
                            }
                            .padding(.horizontal)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
                }
                //layoutPriority 调整排版的优先级，默认0
                Spacer().layoutPriority(1)
                
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
                    showFlag = false
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
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height-100)
            .animation(.spring(dampingFraction: 0.5), value: showFlag)
            .animation(.easeInOut(duration: 0.5), value: selectFood)
        }
        .background(Color(.secondarySystemBackground))
    }
}

// contentView扩展，方便定位到想要的selectFood页面
extension ContentView{
    init(selectFood:Food){
        _selectFood = .init(initialValue: selectFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        ContentView(selectFood: Food.examples.first!)
    }
}
