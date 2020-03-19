//
//  CSV.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/18/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Foundation
import CSV

enum HeaderRow: String {
   case startDate = "Start Date"
    case endDate = "End Date"
    case totalTime = "Time active"
    var description: String {
        get {
            return self.rawValue
        }
    }
}

class Data {
    private static func initializeCSV(path: String)throws -> [String]? {
        if !FileManager.default.fileExists(atPath: path) {
            if !FileManager.default.createFile(atPath: path, contents: nil, attributes: nil) {
                throw DataError.notInitialize
            }
        }
        
        guard let stream = InputStream(fileAtPath: path) else {
            return nil
        }

        do {
            let csv = try CSVReader(stream: stream)
            return csv.next()
        } catch {
            return nil
        }
    }
    
    static func writeCSV(startDate: Date, endDate: Date, totalTime: TimeInterval, fileUrl: URL) throws -> Void {
        let stringTotal = Helper.formatInterval(for: totalTime)
        let path = fileUrl.appendingPathComponent("log.csv").path

        let firstRow = try! Data.initializeCSV(path: path)

        guard let stream = OutputStream(toFileAtPath: path, append: true) else {
            throw DataError.notWrite
        }
        
        let row = [startDate.description, endDate.description, stringTotal]
        print(row)
        do {
            let csv = try CSVWriter(stream: stream)
            
            // if it does not have a header row
            if !Data.hasFirstRow(for: firstRow) {
                try csv.write(row: [HeaderRow.startDate.description, HeaderRow.endDate.description, HeaderRow.totalTime.description])
            }
            
            // write cells
            try csv.write(row: [startDate.description, endDate.description, stringTotal])
            csv.stream.close()
        } catch {
            throw DataError.notWrite
        }
    }
    
    private static func hasFirstRow(for headerRow: [String]?) -> Bool {
        if headerRow == nil {
            return false
        }
        
        for cell in headerRow! {
            switch(cell) {
            case HeaderRow.startDate.description:
                return true
            case HeaderRow.endDate.description:
                return true
            case HeaderRow.totalTime.description:
                return true
            default:
                return false
                
            }
        }
        
        return false
    }
}

enum DataError: Error {
    case notInitialize
    case notWrite
}
