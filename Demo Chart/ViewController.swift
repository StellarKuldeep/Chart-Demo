//
//  ViewController.swift
//  Demo Chart
//
//  Created by Stellarbee on 19/11/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Highcharts

class ViewController: UIViewController {

    @IBOutlet weak var vwPortraitChart: UIView!
    var portraitChartView: HIChartView!
    
    var arrGraphData = ["2019-11-01", "2019-11-02", "2019-11-03", "2019-11-04", "2019-11-05", "2019-11-06", "2019-11-07", "2019-11-08"]
    var arrActualData = [NSNull(), 80, NSNull(), NSNull(), 45, 30, NSNull(), 10] as [Any]
    var arrGoalData = [10, 30, NSNull(), NSNull(), 8, 80, NSNull(), 89] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addPortraitChartView()
    }
    
    func addPortraitChartView() {
        portraitChartView = HIChartView(frame: self.vwPortraitChart.bounds)
        
        //chartView.theme = "grid-light"  // FOR GRID TYPE CHART BACKGROUD
        portraitChartView.backgroundColor = UIColor.white
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "line"
        chart.zoomType      = "x"
        chart.pinchType     = "x"
        chart.panning       = 1
        
        chart.marginTop = 40
        let title = HITitle()
        title.text = " "
        
        let xaxis = HIXAxis()
        xaxis.min = 0
        
        xaxis.max = NSNumber(value: Int32(self.arrGraphData.count - 1))
        xaxis.categories = arrGraphData
        
        let yaxis = HIYAxis()
        yaxis.title = HITitle()
        yaxis.title.text = ""
        
        let plotoptions = HIPlotOptions()
        plotoptions.line = HILine()
        
        //OLD CODE WHICH WORKS FINE IN v7.1.1
        
        //        plotoptions.line.dataLabels = HIDataLabelsOptionsObject()
        //        plotoptions.line.dataLabels.enabled = 1
        //        plotoptions.line.enableMouseTracking = 0
        //
        //        //HIDE 0 VALUE
        //        plotoptions.line.dataLabels.formatter = HIFunction(jsFunction: "function() { if(this.y > 0) return ' ' + this.y; }")
        
        //v7.2.1 NOT DRAW THE LINES IN CHART
        
        let dataLabels = HIDataLabelsOptionsObject()
        dataLabels.enabled = true
        dataLabels.formatter = HIFunction(jsFunction: "function() { if(this.y > 0) return ' ' + this.y; }")
        plotoptions.line.dataLabels = [dataLabels]
        plotoptions.line.enableMouseTracking = 0
        
        let line1 = HILine()
        line1.color = HIColor.init(hexValue: "4285f4")
        
        //ACTUAL DATA
        line1.data = arrActualData
        line1.connectNulls = true
        
        //GOAL DATA
        let line2 = HILine()
        line2.color = HIColor.init(hexValue: "db4437")
        line2.dashStyle = "Dot"
        
        line2.data = arrGoalData
        line2.connectNulls = true
        
        options.chart = chart
        options.title = title
        //        options.subtitle = subtitle
        options.xAxis = [xaxis]
        options.yAxis = [yaxis]
        options.plotOptions = plotoptions
        
        options.series = [line1, line2]
        
        //Below 3 lines for Hiding right Hamburger Menu
        let exporting = HIExporting()
        exporting.enabled = false
        options.exporting = exporting
        
        portraitChartView.options = options
        portraitChartView.options.credits.enabled = 0 // HIDE BOTTOM HIGHCHARTS LABEL
        
        self.vwPortraitChart.addSubview(portraitChartView)
    }
}

