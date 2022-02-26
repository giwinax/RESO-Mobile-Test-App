//
//  OfficeModel.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import Foundation
import CoreLocation

struct OfficeListModel: Decodable {
    let IDOKRUG: Int
    let NDISTANSE: Double
    let NLONG: Double
    let SADDRESS: String
    let SSHORTNAME: String
    let SSHORTADDRESS: String
    let LBANKOMAT: Bool?
    let LSPR: Bool?
    let LREG_CENTER: Bool?
    let IDUNDERGROUND: [IDUNDERGROUNDStruct]
    let LPAYBYCARD: Bool?
    let SPHONE: String
    let SGRAF: String?
    let SGRAFSPR: String?
    let GRAF: [GRAFStruct]?
    let NLAT: Double
    let CPHONE: [CPHONEStruct]
    let NTIMEZONE: String
    let ID: Int
    let SEMAIL: String?
    let SWAY: String?
}

struct GRAFStruct: Decodable {
    let SBEGIN: String
    let NDAY: Int
    let SEND: String
}

struct CPHONEStruct: Decodable {
    let SPHONE: String
    let SPHONETYPE: String
    let SPHONEADD: String
}

struct IDUNDERGROUNDStruct: Decodable {
    let SNAME: String
    let ID: Int
    
}

class Office {
    
    public var List: [OfficeListModel] = []
    public var error: Error?
    
    
    init() {
        fetch() { (result) in
            switch result {
            case .success(let data):
                self.List = data
                self.error = nil
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    private func fetch(completion: @escaping (Result<[OfficeListModel], Error>) -> Void) {
        if let url = URL(string: "https://mobile.reso.ru/free/v2/agencies/77") {
            let (data, error) = URLSession.shared.synchronousDataTask(with: url)
            if let data = data {
                do {
                    let jsd = JSONDecoder()
                    let decoded = try jsd.decode([OfficeListModel].self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getNumberOfOffices() -> Int {
        return self.List.count
    }

    
    // TODO: implement func for getting the open/closed data of office using SGRAF/SGRAFSPR
    func isOpen (_ officeId: Int) -> Bool {
        return true
    }
}
