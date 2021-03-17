//
//  MultilineTextField.swift
//  Notes
//
//  Created by Mac HD on 14/03/21.
//

import SwiftUI

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    @State var placeholder: String
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    @Binding var defaultHeight: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.text = placeholder
        textField.textColor = UIColor.lightGray
        textField.delegate = context.coordinator
        textField.keyboardType = .default
        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: placeholder == "Title" ? .largeTitle : .headline)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight, defaultHeight: $defaultHeight)
    }
    
    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>, defaultHeight : Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > defaultHeight.wrappedValue {
            if result.wrappedValue != newSize.height {
                DispatchQueue.main.async {
                    result.wrappedValue = newSize.height // !! must be called asynchronously
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(placeholder: placeholder, text: $text, height: $calculatedHeight, defaultHeight1: $defaultHeight)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        
        var placeholder: String
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var defaultHeight : Binding<CGFloat>
        
        init(placeholder: String, text: Binding<String>, height: Binding<CGFloat>, defaultHeight1: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.placeholder = placeholder
            self.text = text
            self.calculatedHeight = height
            self.defaultHeight = defaultHeight1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeholder
                textView.textColor = UIColor.lightGray
            }
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight, defaultHeight: defaultHeight)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
    }
}

struct MultilineTextField: View {
    
    private var placeholder: String
    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
        }
    }
    @Binding var dynamicHeight: CGFloat
    @Binding var defaultHeight: CGFloat
    
    init (_ placeholder: String, text: Binding<String>, dynamicHeight: Binding<CGFloat>, defaultHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self._text = text
        self._dynamicHeight = dynamicHeight
        self._defaultHeight = defaultHeight
    }
    
    var body: some View {
        UITextViewWrapper(placeholder: self.placeholder, text: self.internalText, calculatedHeight: $dynamicHeight, defaultHeight : $defaultHeight)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
    }
    
    
}

