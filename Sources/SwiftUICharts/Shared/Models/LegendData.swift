//
//  LegendData.swift
//  LineChart
//
//  Created by Will Dale on 02/01/2021.
//

import SwiftUI

/**
 Data model to hold data for Legends
 */
public struct LegendData: Hashable, Identifiable {
    
    public var id: UUID
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
    }
    /// The type of chart being used.
    public var chartType: ChartType
    
    /// Text to be displayed
    public var legend: String
    
    /// Style of the stroke
    public var strokeStyle: Stroke?
    
    /// Used to make sure the charts data legend is first
    public let prioity: Int
    
    public var colour: ColourStyle
    
    public var touchAction: ((String) -> Void)?

    public static func == (lhs: LegendData, rhs: LegendData) -> Bool {
        lhs.id.uuidString == rhs.id.uuidString
    }

    /// Legend.
    /// - Parameters:
    ///   - legend: Text to be displayed.
    ///   - colour: Colour styling.
    ///   - strokeStyle: Stroke Style.
    ///   - prioity: Used to make sure the charts data legend is first.
    ///   - chartType: Type of chart being used.
    public init(id: UUID,
                legend: String,
                colour: ColourStyle,
                strokeStyle: Stroke?,
                prioity: Int,
                chartType: ChartType,
                touchAction: ((String) -> Void)? = nil
    ) {
        self.id = id
        self.legend = legend
        self.colour = colour
        self.strokeStyle = strokeStyle
        self.prioity = prioity
        self.chartType = chartType
        self.touchAction = touchAction
    }
    
    public mutating func setTouchAction(touchAction: ((String) -> Void)?) {
        self.touchAction = touchAction
    }
}
