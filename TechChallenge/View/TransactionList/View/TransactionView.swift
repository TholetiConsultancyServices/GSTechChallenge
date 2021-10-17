//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    let viewItem: TransactionViewItem
    let pinStateBlock: (Bool) -> Void
    @State private var isPinned: Bool = false


    init(_ item: TransactionViewItem, pinStateBlock: @escaping (Bool) -> Void) {
        self.viewItem = item
        self.pinStateBlock = pinStateBlock
        self.isPinned = item.isPinned
    }

    var body: some View {
        VStack {
            HStack {
                Text(viewItem.categoryName)
                    .font(.headline)
                    .foregroundColor(viewItem.categoryColor)
                Spacer()

                Button(action: {
                    self.isPinned.toggle()
                    pinStateBlock(isPinned)
                }, label: {
                    viewItem.pinImage.scaledToFit()
                })
            }

            if !isPinned {

            HStack {
                viewItem.image
                    .resizable()
                    .frame(
                        width: 60.0,
                        height: 60.0,
                        alignment: .top
                    )

                VStack(alignment: .leading) {
                    Text(viewItem.name)
                        .secondary()
                    Text(viewItem.accountName)
                        .tertiary()
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewItem.amount)
                        .bold()
                        .secondary()
                    Text(viewItem.date)
                        .tertiary()
                }
            }
            }
        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TransactionView(TransactionViewItem(TransactionInfo(ModelData.sampleTransactions[0])), pinStateBlock: { _ in })
            TransactionView(TransactionViewItem(TransactionInfo(ModelData.sampleTransactions[1])), pinStateBlock: { _ in })

        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
