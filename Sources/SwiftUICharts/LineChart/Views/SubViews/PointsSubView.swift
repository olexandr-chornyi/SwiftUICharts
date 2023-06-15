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
//                if dataSets.pointStyle.showValue {
//
////                    let point: CGRect = CGRect(x: pointX, y: pointY, width: dataSets.pointStyle.pointSize, height: pointSize)
//
//
//                    Text("\(dataSets.dataPoints[index].value)")
//                        .font(Font.system(size: 7.0))
//                        .foregroundColor(dataSets.pointStyle.fillColour)
//                        .position(x: pointX, y: pointY)
//                }
                GeometryReader { geometry in
                            let frame = geometry.frame(in: CoordinateSpace.local)
                    Text("0")
                        .font(Font.system(size: 7.0))
                        .foregroundColor(dataSets.pointStyle.fillColour)
                        .position(x: frame.origin.x, y: frame.origin.y)
     //                       return Text("\(frame.origin.x), \(frame.origin.y), \(frame.size.width), \(frame.size.height)")
                }
            }
            .animateOnAppear(disabled: disableAnimation, using: animation) {
                self.startAnimation = true
            }
            .animateOnDisappear(disabled: disableAnimation, using: animation) {
                self.startAnimation = false
            }
//            .overlay(
//                        GeometryReader { proxy in
//                            let x: CGFloat = dataSets.pointStyle.pointSize.width / CGFloat(dataSets.dataPoints.count-1)
//                            let y: CGFloat = dataSets.pointStyle.pointSize.height / CGFloat(range)
//                            let offset: CGFloat = dataSets.pointStyle.pointSize / CGFloat(2)
//
//                            let pointX: CGFloat = (CGFloat(index) * x) - offset
//                            let pointY: CGFloat = ((CGFloat(dataSets.dataPoints[index].value - minValue) * -y) + dataSets.pointStyle.pointSize.height) - offset
//
//                            Text("\(dataSets.dataPoints[index].value)")
//                                .font(Font.system(size: 7.0))
//                                .foregroundColor(dataSets.pointStyle.fillColour)
//                                .position(x: 10, y: 20)
//                        }
//                    )
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
