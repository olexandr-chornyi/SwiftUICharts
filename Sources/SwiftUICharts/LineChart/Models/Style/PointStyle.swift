//
//  PointStyle.swift
//  LineChart
//
//  Created by Will Dale on 04/01/2021.
//

import SwiftUI

/**
 Model for controlling the aesthetic of the point markers.
 
 Point markers are placed on top of the line, marking where the data points are.
 */
public class PointStyle: Hashable, ObservableObject {
    
    public static func == (lhs: PointStyle, rhs: PointStyle) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var id = UUID()
    
    /// Overall size of the mark
    public var pointSize: CGFloat
    
    /// Outter ring colour
    public var borderColour: Color
    
    /// Center fill colour
    public var fillColour: Color
    
    /// Outter ring line width
    public var lineWidth: CGFloat
    
    /// Style of the point marks
    public var pointType: PointType
    
    /// Shape of the points
    public var pointShape: PointShape

    /// show value
    @State public var showValue: Bool

    /// show value
    public var valueFont: Font

    var i: Int = 0
    /// Styling for the point markers.
    /// - Parameters:
    ///   - pointSize: Overall size of the mark
    ///   - borderColour: Outter ring colour
    ///   - fillColour: Center fill colour
    ///   - lineWidth: Outter ring line width
    ///   - pointType: Style of the point marks
    ///   - pointShape: Shape of the points
    public init(
        pointSize: CGFloat = 9,
        borderColour: Color = .primary,
        fillColour: Color = Color(.gray),
        lineWidth: CGFloat = 3,
        pointType: PointType = .outline,
        pointShape: PointShape = .circle,
        showValue: Bool = false,
        valueFont: Font = Font.system(size: 8.0)
    ) {
        self.pointSize = pointSize
        self.borderColour = borderColour
        self.fillColour = fillColour
        self.lineWidth = lineWidth
        self.pointType = pointType
        self.pointShape = pointShape
        self.showValue = showValue
        self.valueFont = valueFont
    }
    
    func hideValue() {
        showValue = false
    }
}

public struct PointColour: Hashable {
    public let border: Color
    public let fill: Color
    
    public init(
        border: Color = .primary,
        fill: Color = .primary
    ) {
        self.border = border
        self.fill = fill
    }
}

