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
                ZStack {
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
                }.zIndex(0)
                if dataSets.pointStyle.showValue {
                    ZStack {
                        GeometryReader { geometry in
                            TextView(value: dataSets.dataPoints[index].value,
                                     range: range,
                                     height: geometry.size.height,
                                     minValue: minValue,
                                     index: index,
                                     width: geometry.size.width,
                                     count: dataSets.dataPoints.count,
                                     pointSize: dataSets.pointStyle.pointSize,
                                     color: dataSets.pointStyle.fillColour,
                                     font: dataSets.pointStyle.valueFont,
                                     ignoreZero: dataSets.style.ignoreZero)
                        }
                    }.zIndex(100)
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
                ZStack {
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
                }.zIndex(0)
                if dataSets.pointStyle.showValue {
                    ZStack {
                        GeometryReader { geometry in
                            TextView(value: dataSets.dataPoints[index].value,
                                     range: range,
                                     height: geometry.size.height,
                                     minValue: minValue,
                                     index: index,
                                     width: geometry.size.width,
                                     count: dataSets.dataPoints.count,
                                     pointSize: dataSets.pointStyle.pointSize,
                                     color: dataSets.pointStyle.fillColour,
                                     font: dataSets.pointStyle.valueFont,
                                     ignoreZero: dataSets.style.ignoreZero)
                        }
                    }.zIndex(100)
                }
            }
            .animateOnAppear(disabled: disableAnimation, using: animation) {
                self.startAnimation = true
            }
            .animateOnDisappear(disabled: disableAnimation, using: animation) {
                self.startAnimation = false
            }
            

            
        case .filledOutLine:
            ForEach(dataSets.dataPoints.indices, id: \.self) { index in
                ZStack {
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
                }.zIndex(0)
                if dataSets.pointStyle.showValue {
                    ZStack {
                        GeometryReader { geometry in
                            TextView(value: dataSets.dataPoints[index].value,
                                     range: range,
                                     height: geometry.size.height,
                                     minValue: minValue,
                                     index: index,
                                     width: geometry.size.width,
                                     count: dataSets.dataPoints.count,
                                     pointSize: dataSets.pointStyle.pointSize,
                                     color: dataSets.pointStyle.fillColour,
                                     font: dataSets.pointStyle.valueFont,
                                     ignoreZero: dataSets.style.ignoreZero)
                        }
                    }.zIndex(100)
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
    
    private struct SizePreferenceKey: PreferenceKey {
            static var defaultValue: CGFloat = .zero
            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                value = max(value, nextValue())
            }
        }
    
    
    struct ViewSizeKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
    struct ViewGeometry: View {
        var body: some View {
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ViewSizeKey.self, value: geometry.size)
            }
        }
    }
    
    @State private var textWidth: CGFloat = 8
    
    var value: Double
    var range: Double
    var height: CGFloat
    var minValue: Double
    var index: Int
    var width: CGFloat
    var count: Int
    var pointSize: CGFloat
    var color: Color
    var font: Font
    var ignoreZero: Bool
        
    @State var sizeOfText: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        let x: CGFloat = width / CGFloat(count-1)
        let y: CGFloat = height / CGFloat(range)
        let offset: CGFloat = pointSize / CGFloat(2)

        let pointX: CGFloat = (CGFloat(index) * x) - offset
        let pointY: CGFloat = ((CGFloat(value - minValue) * -y) + height) - offset

        let plusMinus: CGFloat = pointY > height/3 ? -1 : 1
        let plusMinusOffset: CGFloat = pointY > height/3 ? 4 : 12

        
        if !ignoreZero {
            Text("\(Int(value))")
                .font(font)
                .fixedSize(horizontal: true, vertical: false)
                .frame(alignment: .center)
                .foregroundColor(color)
                .background(ViewGeometry())
                .background(Color.white)
                .clipShape(Capsule())
                .position(x: pointX, y: pointY)
                .padding(4)
                .offset(x: textWidth/2, y: (sizeOfText.height/2 + plusMinusOffset) * plusMinus)
                .zIndex(100)
                .onPreferenceChange(ViewSizeKey.self) { sizeOfText = $0 }
        } else {
            if value != 0 {
                Text("\(Int(value))")
                    .font(font)
                    .frame(alignment: .center)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(color)
                    .background(ViewGeometry())
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(4)
                    .position(x: pointX, y: pointY)
                    .offset(x: textWidth/2, y: (sizeOfText.height/2 + plusMinusOffset) * plusMinus)
                    .zIndex(100)
                    .onPreferenceChange(ViewSizeKey.self) { sizeOfText = $0 }
            }
        }
    }
}


extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
