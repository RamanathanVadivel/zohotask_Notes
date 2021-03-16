//
//  LoadingView.swift
//  Notes
//
//  Created by Mac HD on 16/03/21.
//

import SwiftUI

struct LoadingView : View {
    @Binding var isShowLoader : Bool
    var body: some View {
        ZStack {
            if isShowLoader {
                Color.white.opacity(0.50)
                VStack {
                    ActivityIndicator()
                    Text(K.pleaseWait).font(.headline).foregroundColor(Color.black)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Get Custom ActivityIndicator

struct ActivityIndicator: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let act = UIActivityIndicatorView(style: .large)
        act.color = .black
        return act
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
