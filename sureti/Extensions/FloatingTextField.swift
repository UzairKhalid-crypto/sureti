//
//  FloatingTextField.swift
//  sureti
//
//  Created by Devolper.Scorpio on 20/04/2022.
//

import SwiftUI
struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            }).autocapitalization(.none)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Primary_Color"), lineWidth: 1)
                            .frame(height: textFieldHeight))
                .foregroundColor(Color.primary)
                .accentColor(Color.secondary)
                .animation(.linear)
                ///Floating Placeholder
            Text(placeHolderText)
                .font(.custom("Product Sans Regular", size: 12))
                .foregroundColor(Color.secondary)
                .background(Color(UIColor.systemBackground))
                .padding(shouldPlaceHolderMove ?
                         EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) :
                            EdgeInsets(top: 0, leading:15, bottom: 0, trailing: 0))
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
                .animation(.linear)
        }
    }
}

struct RegisterFloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            }).autocapitalization(.none)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                            .frame(height: textFieldHeight))
                .foregroundColor(Color.white)
                .accentColor(Color.secondary)
                .animation(.linear)
                ///Floating Placeholder
            Text(placeHolderText)
                .font(.custom("Product Sans Regular", size: 12))
                .foregroundColor(Color.white)
                .background(Color("Primary_Color"))
                .padding(shouldPlaceHolderMove ?
                         EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) :
                            EdgeInsets(top: 0, leading:15, bottom: 0, trailing: 0))
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
                .animation(.linear)
        }
    }
}
