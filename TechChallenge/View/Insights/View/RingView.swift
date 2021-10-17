//
//  RingView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct RingView: View {
    let viewItems: [ChartViewItem]

    private func gradient(for viewItem: ChartViewItem) -> AngularGradient {
        let color = viewItem.color
        return AngularGradient(
            gradient: Gradient(colors: [color.unsaturated, color]),
            center: .center,
            startAngle: .init(
                offset: viewItem.offset,
                ratio: 0
            ),
            endAngle: .init(
                offset: viewItem.offset,
                ratio: viewItem.ratio
            )
        )
    }

    var body: some View {
        ZStack {
            ForEach(viewItems, id: \.self) { viewItem in
                PartialCircleShape(
                    offset: viewItem.offset,
                    ratio: viewItem.ratio
                )
                .stroke(
                    gradient(for: viewItem),
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
                .overlay(
                    PercentageText(
                        offset: viewItem.offset,
                        ratio: viewItem.ratio,
                        text: viewItem.text
                    )
                )
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double

        func path(in rect: CGRect) -> Path {
            Path(offset: offset, ratio: ratio, in: rect)
        }
    }

    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String

        private func position(for geometry: GeometryProxy) -> CGPoint {
            let rect = geometry.frame(in: .local)
            let path = Path(offset: offset, ratio: ratio / 2.0, in: rect)
            return path.currentPoint ?? .zero
        }

        var body: some View {
            GeometryReader { geometry in
                if ratio != 0 {
                    Text(text)
                        .percentage()
                        .position(position(for: geometry))
                }
            }
        }
    }
}


#if DEBUG
struct RingView_Previews: PreviewProvider {
    static var sampleRing: some View {
        ZStack {
            RingView.PartialCircleShape(offset: 10.0, ratio: 0.15)
                .stroke(
                    Color.red,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )

            RingView.PartialCircleShape(offset: 0.15, ratio: 0.5)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )

            RingView.PartialCircleShape(offset: 0.65, ratio: 0.35)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
        }
    }

    static var previews: some View {
        VStack {
            RingView(viewItems: [ChartViewItem(ratio: 0.15, offset: 10.0, text: "\((0.15 * 100).formatted(hasDecimals: false))%", color: .blue),
                                 ChartViewItem(ratio: 0.5, offset: 0.15, text: "\((0.5 * 100).formatted(hasDecimals: false))%", color: .red),
                                 ChartViewItem(ratio: 0.35, offset: 0.65, text: "\((0.35 * 100).formatted(hasDecimals: false))%", color: .green)])
                .scaledToFit()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
