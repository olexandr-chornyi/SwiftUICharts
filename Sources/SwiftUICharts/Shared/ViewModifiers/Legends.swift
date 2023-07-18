//
//  Legends.swift
//  LineChart
//
//  Created by Will Dale on 02/01/2021.
//

import SwiftUI

/**
 Displays legends under the chart.
 */
internal struct Legends<T>: ViewModifier where T: CTChartData {
    
    @ObservedObject private var chartData: T
    private let columns: [GridItem]
    private let width: CGFloat
    private let font: Font
    private let selectedFont: Font
    private let textColor: Color
    private let topPadding: CGFloat
    var chartsType: ChartType = .line
    var space: CGFloat = 0.0

    internal init(
        chartData: T,
        columns: [GridItem],
        width: CGFloat,
        font: Font,
        selectedFont: Font,
        textColor: Color,
        topPadding: CGFloat,
        chartsType: ChartType = .line,
        space: CGFloat = 0.0
    ) {
        self.chartData = chartData
        self.columns = columns
        self.width = width
        self.font = font
        self.selectedFont = selectedFont
        self.textColor = textColor
        self.topPadding = topPadding
        self.chartsType = chartsType
        self.space = space
    }
    
    internal func body(content: Content) -> some View {
        Group {
            if chartData.isGreaterThanTwo() {
                VStack {
                    content
                    LegendView(chartData: chartData,
                               columns: columns,
                               width: width,
                               font: font,
                               selectedFont: selectedFont,
                               textColor: textColor,
                               chartsType: chartsType,
                               space: space)
                        .padding(.top, topPadding)
                }
            } else { content }
        }
    }
}

extension View {
    /**
     Displays legends under the chart.
     
     - Parameters:
        - chartData: Chart data model.
        - columns: How to layout the legends.
        - textColor: Colour of the text.
     - Returns: A  new view containing the chart with chart legends under.
     */
    public func legends<T:CTChartData>(
        chartData: T,
        columns: [GridItem] = [GridItem(.flexible())],
        iconWidth: CGFloat = 40,
        font: Font = .caption,
        selectedFont: Font = .caption,
        textColor: Color = Color.primary,
        topPadding: CGFloat = 18,
        chartsType: ChartType = .line,
        space: CGFloat = 0.0
    ) -> some View {
        self.modifier(Legends(chartData: chartData,
                              columns: columns,
                              width: iconWidth,
                              font: font,
                              selectedFont: selectedFont,
                              textColor: textColor,
                              topPadding: topPadding,
                              chartsType: chartsType,
                              space: space))
    }
}
