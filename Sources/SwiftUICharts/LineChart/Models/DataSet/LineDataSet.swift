//
//  LineDataSet.swift
//  
//
//  Created by Will Dale on 23/01/2021.
//

import SwiftUI

/**
 Data set for a single line
 
 Contains information specific to each line within the chart .
 */
public struct LineDataSet: CTLineChartDataSet, DataFunctionsProtocol {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    public static func == (lhs: LineDataSet, rhs: LineDataSet) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: UUID = UUID()
    public var dataPoints: [LineChartDataPoint]
    public var legendTitle: String
    public var pointStyle: PointStyle
    public var style: LineStyle
    public var touchAction: ((String) -> Void)?
    
    /// Initialises a data set for a line in a Line Chart.
    /// - Parameters:
    ///   - dataPoints: Array of elements.
    ///   - legendTitle: Label for the data in legend.
    ///   - pointStyle: Styling information for the data point markers.
    ///   - style: Styling for how the line will be draw in.
    public init(
        dataPoints: [LineChartDataPoint],
        legendTitle: String = "",
        pointStyle: PointStyle = PointStyle(),
        style: LineStyle = LineStyle(),
        touchAction: ((String) -> Void)? = nil
    ) {
        self.dataPoints = dataPoints
        self.legendTitle = legendTitle
        self.pointStyle = pointStyle
        self.style = style
        self.touchAction = touchAction
    }
    
    public typealias ID = UUID
    public typealias Styling = LineStyle
}
