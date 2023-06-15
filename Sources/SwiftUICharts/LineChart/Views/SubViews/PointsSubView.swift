//
//  PointsSubView.swift
//  
//
//  Created by Will Dale on 04/02/2021.
//

import SwiftUI

/**
 Sub view gets the point markers drawn, sets the styling and sets up the animations.
 */
internal struct PointsSubView<DS>: View where DS: CTLineChartDataSet,
                                              DS.DataPoint: CTStandardDataPointProtocol & CTLineDataPointProtocol {
    
    private let dataSets: DS
    private let minValue: Double
    private let range: Double
    private let animation: Animation
    private let isFilled: Bool
    private let disableAnimation: Bool
        
    internal init(
        dataSets: DS,
        minValue: Double,
        range: Double,
        animation: Animation,
        isFilled: Bool,
        disableAnimation: Bool
    ) {
        self.dataSets = dataSets
        self.minValue = minValue
        self.range = range
        self.animation = animation
        self.isFilled = isFilled
        self.disableAnimation = disableAnimation
    }
    
    @State private var startAnimation: Bool = false
    
    internal var body: some View {
        
        switch dataSets.pointStyle.pointType {
        case .filled:
            ForEach(dataSets.dataPoints.indices, id: \.self) { index in
                Point(value: dataSets.dataPoints[index].value,
                       index: index,
                       minValue: minValue,
                       range: range,
                       datapointCount: dataSets.dataPoints.count,
                       pointSize: dataSets.pointStyle.pointSize,
                       ignoreZero: dataSets.style.ignoreZero,
                       pointStyle: dataSets.pointStyle.pointShape)
                    .ifElse(!isFilled, if: {
                        $0.trim(to: animationValue)
                            .fill(dataSets.dataPoints[index].pointColour?.fill ?? dataSets.pointStyle.fillColour)
                    }, else: {
                        $0.scale(y: animationValue, anchor: .bottom)
                            .fill(dataSets.dataPoints[index].pointColour?.fill ?? dataSets.pointStyle.fillColour)
                    })
                if dataSets.pointStyle.showValue {
                    Text("\(dataSets.dataPoints[index].value)")
                        .font(Font.system(size: 7.0))
                        .foregroundColor(dataSets.pointStyle.fillColour)
                        .frame(alignment: .center)
                }
            }
            .animateOnAppear(disabled: disableAnimation, using: animation) {
                self.startAnimation = true
            }
            .animateOnDisappear(disabled: disableAnimation, using: animation) {
                self.startAnimation = false
            }
        case .outline:
            ForEach(dataSets.dataPoints.indices, id: \.self) { index in
                if dataSets.pointStyle.showValue {
                    TextView(value: dataSets.dataPoints[index].value,
                             range: range,
                             height: dataSets.pointStyle.pointSize,
                             minValue: minValue,
                             index: index,
                             width: dataSets.pointStyle.pointSize,
                             count: dataSets.dataPoints.count,
                             pointSize: dataSets.pointStyle.pointSize,
                             color: dataSets.pointStyle.fillColour)
                }
                Point(value: dataSets.dataPoints[index].value,
                       index: index,
                       minValue: minValue,
                       range: range,
                       datapointCount: dataSets.dataPoints.count,
                       pointSize: dataSets.pointStyle.pointSize,
                       ignoreZero: dataSets.style.ignoreZero,
                       pointStyle: dataSets.pointStyle.pointShape)
                    .ifElse(!isFilled, if: {
                        $0.trim(to: animationValue)
                            .stroke(dataSets.dataPoints[index].pointColour?.border ?? dataSets.pointStyle.borderColour,
                                    lineWidth: dataSets.pointStyle.lineWidth)
                    }, else: {
                        $0.scale(y: animationValue, anchor: .bottom)
                            .stroke(dataSets.dataPoints[index].pointColour?.border ?? dataSets.pointStyle.borderColour,
                                    lineWidth: dataSets.pointStyle.lineWidth)
                    })
            }
            .animateOnAppear(disabled: disableAnimation, using: animation) {
                self.startAnimation = true
            }
            .animateOnDisappear(disabled: disableAnimation, using: animation) {
                self.startAnimation = false
            }
        case .filledOutLine:
            ForEach(dataSets.dataPoints.indices, id: \.self) { index in
                Point(value: dataSets.dataPoints[index].value,
                       index: index,
                       minValue: minValue,
                       range: range,
                       datapointCount: dataSets.dataPoints.count,
                       pointSize: dataSets.pointStyle.pointSize,
                       ignoreZero: dataSets.style.ignoreZero,
                       pointStyle: dataSets.pointStyle.pointShape)
                    .ifElse(!isFilled, if: {
                        $0.trim(to: animationValue)
                            .stroke(dataSets.dataPoints[index].pointColour?.border ?? dataSets.pointStyle.borderColour,
                                    lineWidth: dataSets.pointStyle.lineWidth)
                    }, else: {
                        $0.scale(y: animationValue, anchor: .bottom)
                            .stroke(dataSets.dataPoints[index].pointColour?.border ?? dataSets.pointStyle.borderColour,
                                    lineWidth: dataSets.pointStyle.lineWidth)
                    })
                    .background(Point(value: dataSets.dataPoints[index].value,
                                       index: index,
                                       minValue: minValue,
                                       range: range,
                                       datapointCount: dataSets.dataPoints.count,
                                       pointSize: dataSets.pointStyle.pointSize,
                                       ignoreZero: dataSets.style.ignoreZero,
                                       pointStyle: dataSets.pointStyle.pointShape)
                                    .foregroundColor(dataSets.dataPoints[index].pointColour?.fill ?? dataSets.pointStyle.fillColour)
                    )
                if dataSets.pointStyle.showValue {
                    Text("\(dataSets.dataPoints[index].value)")
                        .font(Font.system(size: 7.0))
                        .foregroundColor(dataSets.pointStyle.fillColour)
                        .frame(alignment: .center)
                }
            }
            .animateOnAppear(disabled: disableAnimation, using: animation) {
                self.startAnimation = true
            }
            .animateOnDisappear(disabled: disableAnimation, using: animation) {
                self.startAnimation = false
            }
        }
    }
    
    var animationValue: CGFloat {
        if disableAnimation {
            return 1
        } else {
            return startAnimation ? 1 : 0
        }
    }
}

struct TextView: View {
    
    var value: Double
    var range: Double
    var height: CGFloat
    var minValue: Double
    var index: Int
    var width: CGFloat
    var count: Int
    var pointSize: CGFloat
    var color: Color
        
    var body: some View {
        let x: CGFloat = width / CGFloat(count-1)
        let y: CGFloat = height / CGFloat(range)
        let offset: CGFloat = pointSize / CGFloat(2)

        let pointX: CGFloat = (CGFloat(index) * x) - offset
        let pointY: CGFloat = ((CGFloat(value - minValue) * -y) + height) - offset

        ZStack {
            Text("\(value)")
                .font(Font.system(size: 7.0))
                .foregroundColor(color)
                .position(x: pointX, y: pointY + height)
                .frame(alignment: .center)
            
        }
    }
}
