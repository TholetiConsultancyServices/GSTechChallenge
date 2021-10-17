//
//  CategoryGridView.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct CategoryGridView: View {

    let viewItems: [TransactionViewCategory]
    var selectedCategroyBlock: (TransactionViewCategory) -> Void

    private let rows = [ GridItem(.adaptive(minimum: 50))]
    // @Binding var selectedCategory: CategoryViewItem

    var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(viewItems, id: \.self) { viewItem in

                        Button(action: {
                            self.selectedCategroyBlock(viewItem)
                        }, label: {
                            Text(viewItem.text)
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                        })
                        .frame(height: 40)
                        .background(viewItem.color)
                        .cornerRadius(20.0)

                    }
                }
                .frame(height: 80)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .background(Color.accentColor)
            .opacity(0.8)
        }
}


#if DEBUG
struct CategoryGridView_Previews: PreviewProvider {

    static var previews: some View {
        CategoryGridView(viewItems: [TransactionViewCategory.food, TransactionViewCategory.travel], selectedCategroyBlock: { _ in })
    }
}

#endif
