//
//  SwiftUIView.swift
//  
//
//  Created by Oleksandr Chornyi1 on 16/06/2023.
//

import SwiftUI
import Combine

struct MultiLineChartDemoView: View {
    
    @State var data : MultiLineChartData = MultiLineChartData(dataSets: MultiLineDataSet(dataSets: []))
        
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
                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 150, maxHeight: 200, alignment: .center)
                .padding(.horizontal)
        }
        .onAppear {
            data = weekOfData()
        }
        .navigationTitle("Week of Data")
    }

    func weekOfData() -> MultiLineChartData {
        let dataSet = MultiLineDataSet(dataSets: [
            LineDataSet(dataPoints: [
                LineChartDataPoint(value: 0, xAxisLabel: "M", description: "May"),
                LineChartDataPoint(value: 12.1, xAxisLabel: "M", description: "May"),
                LineChartDataPoint(value: 15.1, xAxisLabel: "J", description: "June"),
                LineChartDataPoint(value: 17.3, xAxisLabel: "J", description: "July"),
                LineChartDataPoint(value: 0),
            ],
            legendTitle: "London",
                        pointStyle: PointStyle( borderColour: .blue, fillColour: .blue, pointType: .filledOutLine, pointShape: .circle, showValue: true),
            style: LineStyle(lineColour: ColourStyle(colour: .blue), lineType: .line, ignoreZero: true),
                        touchAction: { id in
                            print("222: \(id)")
                            data.dataSets.dataSets.forEach { lineDataSet in
                                lineDataSet.pointStyle.hideValue()
                            }
//                            data.dataSets.dataSets.forEach { lineDataSet in
//                                print("show values: \(lineDataSet.pointStyle.showValue)")
//                            }
//                            print("222: \(id)")
                        }),
            
        ])
        
        
        let multiLineChartData = MultiLineChartData(dataSets: dataSet,
                                                    chartStyle: LineChartStyle(infoBoxPlacement: .floating,
                                                                               markerType: .full(attachment: .line(dot: .style(DotStyle()))),
                                                                               xAxisGridStyle: GridStyle(numberOfLines: 10),
                                                                               yAxisGridStyle: GridStyle(numberOfLines: 4),
                                                                               yAxisNumberOfLabels: 4,
                                                                               baseline: .zero,
                                                                               topLine: .maximumValue))
        
        return multiLineChartData
    }
}

struct MultiLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineChartDemoView()
            .preferredColorScheme(.dark)
    }
}
