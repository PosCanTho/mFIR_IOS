//
//  ReportIssue.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

struct ReportIssue {
    var componentName: String
    var description: String
    var componentID: String
    var checked: Bool = false
}

struct TIBReportIssue {
    static func getAll() -> [ReportIssue] {
        return [
            ReportIssue(componentName: "Đèn/Điện", description: "", componentID: "1",checked: false),
            ReportIssue(componentName: "Cable/Wifi", description: "", componentID: "2",checked: false),
            ReportIssue(componentName: "Bảng/Phấn/Bút", description: "", componentID: "3",checked: false),
            ReportIssue(componentName: "Màn chiếu/Máy chiếu", description: "", componentID: "5",checked: false),
            ReportIssue(componentName: "Máy lạnh/Quạt", description: "", componentID: "6",checked: false),
            ReportIssue(componentName: "Tivi/Tủ lạnh", description: "", componentID: "7",checked: false),
            ReportIssue(componentName: "Bàn ủi/Quạt máy", description: "", componentID: "8",checked: false),
            ReportIssue(componentName: "Máy lạnh/Máy hàn/Máy phát điện", description: "", componentID: "9",checked: false),
            ReportIssue(componentName: "Máy rung", description: "", componentID: "10",checked: false),
            ReportIssue(componentName: "Máy bay", description: "", componentID: "11",checked: false)
        ]
    }
}
