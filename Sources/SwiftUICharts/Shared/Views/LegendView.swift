//
//  LegendView.swift
//  LineChart
//
//  Created by Will Dale on 09/01/2021.
//

import SwiftUI

/**
 Sub view to setup and display the legends.
 */
internal struct LegendView<T>: View where T: CTChartData {
    
    @ObservedObject private var chartData: T
    private let columns: [GridItem]
    private let width: CGFloat
    private let font: Font
    private let selectedFont: Font
    private let textColor: Color
    var chartsType: ChartType = .line
    var space: CGFloat = 0.0
    
    internal init(chartData: T,
                  columns: [GridItem],
                  width: CGFloat,
                  font: Font,
                  selectedFont: Font,
                  textColor: Color,
                  chartsType: ChartType = .line,
                  space: CGFloat = 0.0
    ) {
        self.chartData = chartData
        self.columns = columns
        self.width = width
        self.font = font
        self.selectedFont = selectedFont
        self.textColor = textColor
        self.chartsType = chartsType
        self.space = space
    }
    
    internal var body: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(chartData.legends, id: \.id) { legend in
                legend.getLegend(width: width, font: font, selectedFont: selectedFont, textColor: textColor, chartsType: chartsType, space: space)
                    .if(scaleLegendBar(legend: legend)) { $0.scaleEffect(1.2, anchor: .leading) }
                    .if(scaleLegendPie(legend: legend)) { $0.scaleEffect(1.2, anchor: .leading) }
                    .accessibilityLabel(LocalizedStringKey(legend.accessibilityLegendLabel()))
                    .accessibilityValue(LocalizedStringKey(legend.legend))
            }
        }
    }
    
    /// Detects whether to run the scale effect on the legend.
    private func scaleLegendBar(legend: LegendData) -> Bool {
        if let chartData = chartData as? BarChartData,
           let datapoint = chartData.infoView.touchOverlayInfo.first {
            return chartData.infoView.isTouchCurrent && legend.id == datapoint.id
        }
        if let chartData = chartData as? GroupedBarChartData,
           let datapoint = chartData.infoView.touchOverlayInfo.first {
            return chartData.infoView.isTouchCurrent && legend.colour == datapoint.group.colour
        }
        if let chartData = chartData as? StackedBarChartData,
           let datapoint = chartData.infoView.touchOverlayInfo.first {
            return chartData.infoView.isTouchCurrent && legend.colour == datapoint.group.colour
        }
        return false
    }
    
    /// Detects whether to run the scale effect on the legend.
    private func scaleLegendPie(legend: LegendData) -> Bool {
        
        if chartData is PieChartData || chartData is DoughnutChartData {
            if let datapointID = chartData.infoView.touchOverlayInfo.first?.id as? UUID {
                return chartData.infoView.isTouchCurrent && legend.id == datapointID
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
