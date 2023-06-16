//
//  SwiftUIView.swift
//  
//
//  Created by Oleksandr Chornyi1 on 16/06/2023.
//

import SwiftUI

struct MultiLineChartDemoView: View {
    
    let data : MultiLineChartData = weekOfData()
        
    var body: some View {
        VStack {
            MultiLineChart(chartData: data)
                .touchOverlay(chartData: data, specifier: "%.01f", unit: .suffix(of: "ºC"))
                .pointMarkers(chartData: data)
                .xAxisGrid(chartData: data)
                .yAxisGrid(chartData: data)
                .xAxisLabels(chartData: data)
                .yAxisLabels(chartData: data, specifier: "%.01f")
                .floatingInfoBox(chartData: data)
                .headerBox(chartData: data)
                .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], chartsType: .pie)
                .id(data.id)
                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                .padding(.horizontal)
        }
        .navigationTitle("Week of Data")
    }

    static func weekOfData() -> MultiLineChartData {
        let data = MultiLineDataSet(dataSets: [
            LineDataSet(dataPoints: [
                LineChartDataPoint(value: 12.1, xAxisLabel: "M", description: "May"),
                LineChartDataPoint(value: 15.1, xAxisLabel: "J", description: "June"),
                LineChartDataPoint(value: 17.3, xAxisLabel: "J", description: "July"),
            ],
            legendTitle: "London",
                        pointStyle: PointStyle(fillColour: .blue, pointType: .outline, pointShape: .circle, showValue: true),
            style: LineStyle(lineColour: ColourStyle(colour: .red), lineType: .line)),
            
        ])
        
        return MultiLineChartData(dataSets: data,
                                  xAxisLabels: ["January", "December"],
                                  chartStyle: LineChartStyle(infoBoxPlacement: .floating,
                                                             markerType: .full(attachment: .line(dot: .style(DotStyle()))),
                                                             xAxisGridStyle: GridStyle(numberOfLines: 12),
                                                             yAxisGridStyle: GridStyle(numberOfLines: 5),
                                                             yAxisNumberOfLabels: 5,
                                                             baseline: .minimumValue,
                                                             topLine: .maximumValue))
    }
}

struct MultiLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineChartDemoView()
            .preferredColorScheme(.dark)
    }
}
