//
//  TotalSumView.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct TotalSumView: View {

    let viewItem: TotalSumViewItem

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Spacer()

                    Text(viewItem.category)
                        .foregroundColor(viewItem.categoryColor)
                        .font(.headline)
                }

                HStack {
                    Text("Total spent:")
                        .secondary()

                    Spacer()

                    Text(viewItem.sum)
                        .fontWeight(.bold)
                        .secondary()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        .frame(height: 70)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0).stroke(Color.accentColor, lineWidth: 2)
        )
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
    }
}


#if DEBUG
struct TotalSumView_Previews: PreviewProvider {
    static var previews: some View {
        TotalSumView(viewItem: TotalSumViewItem(category: "all", categoryColor: .blue, sum: "$ 15.50"))
    }
}
#endif

