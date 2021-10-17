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
                        .fontWeight(.bold)
                }

                Spacer()

                HStack {
                    Text("Total spent")
                        .secondary()

                    Spacer()

                    Text(viewItem.sum)
                        .fontWeight(.bold)
                        .secondary()
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(height: 70)
        .border(Color.accentColor, width: 2)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}


#if DEBUG
struct TotalSumView_Previews: PreviewProvider {
    static var previews: some View {
        TotalSumView(viewItem: TotalSumViewItem(category: "all", categoryColor: .blue, sum: "$ 15.50"))
    }
}
#endif

