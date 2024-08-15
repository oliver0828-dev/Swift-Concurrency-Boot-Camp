//
//  DoCatchTryThrowBootcamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Oliver Park on 8/15/24.
//

import SwiftUI

class DoCatchTryThrowBootcampDataManager {
    
    let isActive: Bool = false
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT!")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "NEW TEXT!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}


class DoCatchTryThrowBootcampViewModel: ObservableObject {
    let manager = DoCatchTryThrowBootcampDataManager()
    @Published var text: String = "Starting Text"
    
    func fetchTitle() {
        /*
        let returnedValue = manager.getTitle()
        
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */
        
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case.failure(let error):
            self.text = error.localizedDescription
        }
    }
}


struct DoCatchTryThrowBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowBootcamp()
}
