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
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text(viewItem.category)
                }

                HStack {
                    Text("Total spent")
                    Spacer()
                    Text(viewItem.sum)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(height: 70)
        .border(Color.accentColor, width: 2)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}


#if DEBUG
struct TotalSumView_Previews: PreviewProvider {
    static var previews: some View {
        TotalSumView(viewItem: TotalSumViewItem(category: "all", sum: "$ 15.50"))
    }
}
#endif

