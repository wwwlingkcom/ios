//
//  FoodListView.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/10.
//

import SwiftUI

struct FoodListView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dynamicTypeSize) var textSize
    @State private var food = Food.examples
    @State private var selectFood = Set<Food.ID>()
    
    //列表是否为编辑模式
    private var isEditMode : Bool{editMode?.wrappedValue == .active}
    
    var body: some View {
        VStack(alignment: .leading){
            
            titleBar
            
            //        List($food,id: \.name, editActions: .all) { food in
            //            Text(food.wrappedValue.name)
            //        }
            List($food, editActions: .all,selection: $selectFood) { $food in
                Text(food.name).padding()
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .background(.groupBG)
        .safeAreaInset(edge: .bottom,content: createDealButton)
        .sheet(isPresented: .constant(true)) {
            let food = food[1]
            //如果是辅助模式，或者有两个失误图片的话 使用vstack模式
            let shouldVstack = textSize.isAccessibilitySize || food.image.count > 1
            //anylayout使用，根据某个条件分别生产vstack 和 hstack
            AnyLayout.useVstack(if: shouldVstack, spacing: 30){
                Text(food.image).font(.system(size: 100)).lineLimit(1).minimumScaleFactor(0.5)
                
                Grid(horizontalSpacing: 30,verticalSpacing: 12){
                    buildSheetView(title: "热量", value: food.$calorie)
                    buildSheetView(title: "蛋白质", value: food.$protein)
                    buildSheetView(title: "脂肪", value: food.$fat)
                    buildSheetView(title: "碳水化合物", value: food.$carb)
                }
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
    
}

extension AnyLayout {
    static func useVstack(if condition: Bool,spacing:CGFloat,@ViewBuilder  content: @escaping ()->some View) -> some View{
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        
        return layout(content)
    }
}

extension FoodListView {
    var titleBar:some View{
        HStack{
            Label("食物清单", systemImage: "fork.knife")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            EditButton().buttonStyle(.bordered)
            
        }.padding()
    }
    
    var addButton:some View {
        Button {
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white,Color.accentColor)
        }

    }
    
    var deleteButton : some View{
        Button {
            withAnimation{
                food = food.filter{!selectFood.contains($0.id)}
            }
        } label: {
            Text("删除")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .setButtonStyle()
        .padding(.horizontal,60)
    }
    
    func createDealButton() -> some View {
        ZStack{
            deleteButton
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditMode ? 1 : 0)
                .id(isEditMode)
            addButton
                .scaleEffect(isEditMode ? 0 : 1)
                .opacity(isEditMode ? 0 : 1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .animation(.easeInOut, value: isEditMode)
        }
    }
    
    func buildSheetView(title: String,value: String) -> some View{
        GridRow {
            Text(title).gridCellAnchor(.leading)
            Text(value).gridCellAnchor(.trailing)
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FoodListView()
//            .environment(\.dynamicTypeSize, .accessibility1)
    }
}
