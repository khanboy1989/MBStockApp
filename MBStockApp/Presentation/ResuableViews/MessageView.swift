//
//  MessageView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//

import SwiftUI

/// MessageView for showing an error / message
/// Whichever the view implements the BaseStateView
struct MessageView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Hello World!")
    }
}
