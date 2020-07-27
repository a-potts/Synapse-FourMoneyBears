//
//  MacawChartView.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import Macaw


class MacawChartView: MacawView {
    
    
    static let lastFiveShows = createDummyData()
    static let maxValue = 500000
    static let maxValueLineHeight = 180
    static let lineWidth: Double = 275
    
    // Conver into number that fits into coordiante system
    static let dataDivisor = Double(maxValue/maxValueLineHeight)
    static let adjustedData: [Double] = lastFiveShows.map({ $0.viewCount / dataDivisor})
    static var animations: [Animation] = [] // Macaw object
    
    required init?(coder aDecoder: NSCoder){
        super.init(node: MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = .clear
    }
    
    // The group is what has an array of nodes, the nodes are what create all of the visuals
    private static func createChart() -> Group {
        var items: [Node] = addYaxisItem() + addXaxisItem()
        items.append(createBars())
        
        return Group(contents: items, place: .identity)
    }
    
    private static func addYaxisItem() -> [Node]{
        let maxLines = 6 // max numbers of Y axis going up
        let lineInterval = Int(maxValue/maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 30
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.white.with(a: 0.10))
            
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline:  .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    private static func addXaxisItem() -> [Node]{
        let chartBaseY: Double  = 200
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50)
            let valueText = Text(text: lastFiveShows[i - 1].showNumber, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15) )
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    private static func createBars() -> Group {
        
        return Group()
    }
    
    
    
    // Return array of dummy data
    private static func createDummyData() -> [DummyData] {
        let one = DummyData(showNumber: "55", viewCount: 123456)
        let two = DummyData(showNumber: "56", viewCount: 234567)
        let three = DummyData(showNumber: "57", viewCount: 345678)
        let four = DummyData(showNumber: "58", viewCount: 456789)
        let five = DummyData(showNumber: "59", viewCount: 123457)
        
        return [one, two, three, four, five]
        
    }
}
