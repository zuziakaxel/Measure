//
//  MeasureViewController.swift
//  AccelerometerFun
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 David Fry. All rights reserved.
//

import UIKit
import CoreMotion
import Charts


class MeasureViewController: UIViewController {
    
    @IBOutlet weak var chart: LineChartView!
    
    @IBOutlet weak var btnStartStop: UIButton!
    
    
    var manager: MeasurementData!
    
    var started: Bool = false
    
    var data: [Double] = []
    var distanceResult: [Double] = []
    
    let motionManager = CMMotionManager()
    
    var startDate: NSDate!
    var endDate: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStartStop.setTitle("Start", forState: .Normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btnStartStopTapped(sender: AnyObject) {
        started = !started
        let title = started ? "Stop" : "Start"
        btnStartStop.setTitle(title, forState: .Normal)

        if started {
            start()
        } else {
            stop()
        }
    }
    
    
    
    func start() {
        manager = MeasurementData()
        startDate = NSDate()
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {
            accelerometerData, error in
            if error != nil {
                print(error)
            } else {
                self.manager.addX(accelerometerData!.acceleration)
                self.data.append(accelerometerData!.acceleration.x)
                print(NSString(format:"%.2f", accelerometerData!.acceleration.x) as String)
            }
            
        })
    }
    
    func stop() {
        motionManager.stopAccelerometerUpdates()
        distanceResult.append(manager.getDistance())
//        endDate = NSDate()
//        let average = self.calculateAverage()
//        let interval = endDate.timeIntervalSinceDate(startDate)
//        let distance = (average * pow(interval, 2) ) / 2.0
//        self.distanceResult.append(distance)
//        print("Average: \(average) m/s2\n Interval: \(interval)\n distance in meters: \(distance)")
        setChartData(distanceResult)
        print("COunt: \(manager.data.count)")
        
    }

    func setChartData(values: [Double]) {
        var chartDataArr: [ChartDataEntry] = []
        var xVals: [Int] = []
        var sum = 0.0
        for i in 0..<values.count {
            let chartDataEntry = ChartDataEntry(value: 100*values[i], xIndex: i)
            xVals.append(i)
            chartDataArr.append(chartDataEntry)
            sum += 100*values[i]
        }
        let lineChartDataSet = LineChartDataSet(yVals: chartDataArr, label: "Distance")
        let lineChartData = LineChartData(xVals: xVals, dataSet: lineChartDataSet)
        let ll = ChartLimitLine(limit: sum/Double(values.count), label: "Average")
        chart.rightAxis.removeAllLimitLines()
        chart.rightAxis.addLimitLine(ll)
        chart.data = lineChartData
        
    }
    
    
    func calculateAverage() -> Double {
        var sum:Double = 0.0
        for i in 0..<data.count {
            sum += abs(data[i])
        }
        let average:Double = sum/Double(data.count)
        
        return average*9.82
    }
}
