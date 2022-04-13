//
//  FileLoader.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation

class FileLoader {

    static func readLocalFile(_ filename: String) -> Data? {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json")
            else {
                fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }

        do {
            return try String(contentsOfFile: file).data(using: .utf8)
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }


    static func loadJson(_ data: Data) -> CurrencyData {
        do {
            return try JSONDecoder().decode(CurrencyData.self, from: data)
        } catch {
            fatalError("Unable to decode  \"\(data)\" as \(CurrencyData.self):\n\(error)")
        }
    }
}
