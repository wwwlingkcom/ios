//
//  ContentView.swift
//  Demo
//
//  Created by 木丁西 on 2023/12/29.
//

import SwiftUI


struct ContentView: View {
    @State private var selectFood:Food?
    @State private var showFlag:Bool = false
    
    let foodList = Food.examples
    
    var body: some View {
        ScrollView{
            VStack (spacing: 20){
                foodImage
                
                Text("今天吃啥？").bold().font(.largeTitle)
                
                selectFoodInfoView
                
                //layoutPriority 调整排版的优先级，默认0
                Spacer().layoutPriority(1)
                
                selectButton
                
                cancelButton
            }
            /**
             .font()  设置vstack中所有的text的字体大小，
             有个特殊点：vstack中有text设置过字体大小的话，此设置不会覆盖之前的，即保持里面的设置大小
             */
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height-100)
            .setButtonStyle()
            .controlSize(.large)
            .animation(.mySpring, value: showFlag)
            .animation(.myeaseInOut, value: selectFood)
        }
        .background(Color.bg2)
    }
}

//MARK: -些子view
private extension ContentView {
    
    var foodImage : some View {
        Group{
            if let selectFood {
                Text(selectFood.image)
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
    }
    
    var selectFoodNameView : some View {
        HStack{
            Text(selectFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
                .id(selectFood!.name)
                .transition(.delayInsertionOpacity)
            Button(){
                showFlag.toggle()
            }label: {
                Image(systemName: "info.circle.fill").foregroundColor(.secondary)
            }.buttonStyle(.plain)
            
        }
    }
    
    var selectFoodExtendInfoView : some View {
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
                        Text(selectFood!.$carb)
                        Text(selectFood!.$fat)
                        Text(selectFood!.$protein)
                    }
                }
                .padding(.horizontal)
                .padding()
                .setRoundedRectBackGround()
                .transition(.moveUpWithOpacity)
            }
        }
    }
    
    /**
     闭包方式，只支持一行时才可以省略return关键字，多行时或者不是view时，如何处理成一个view？
        方式1：@ViewBuilder
        方式2：使用group包括起来---- 底层也是方式1
     */
    @ViewBuilder var selectFoodInfoView : some View {
//        Group{
//            if selectFood != .none{
            if let selectFood {
                
                selectFoodNameView
                
//                Text("热量: \(selectFood!.calorie.formatted()) 大卡")
                Text("热量: \(selectFood.$calorie) ")
                
                selectFoodExtendInfoView
                
                .frame(maxWidth: .infinity)
                .clipped()
            }
//        }
    }
    
    var selectButton : some View{
        Button(role: .none){
            selectFood = foodList.shuffled().filter{$0 != selectFood}.first
        } label: {
            Text(selectFood == .none ? "告诉我" : "换一个").frame(width: 200)
            //文字变化需要单独设定
                .transformEffect(.identity)
            //文字关闭动画
                .animation(.none, value: selectFood)
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom,-10)
        
    }
    
    var cancelButton : some View {
        Button(role: .none){
            selectFood = .none
            showFlag = false
        } label: {
            Text("重置").frame(width: 200)
        }
        .buttonStyle(.bordered)
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
