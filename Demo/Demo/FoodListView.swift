//
//  FoodListView.swift
//  Demo
//
//  Created by 木丁西 on 2024/1/10.
//

import SwiftUI

struct FoodListView: View {
    @Environment(\.editMode) private var editMode
    @State private var food = Food.examples + Food.examples
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
                Text(food.name)
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .background(.groupBG)
        .safeAreaInset(edge: .bottom,content: createDealButton)
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
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
