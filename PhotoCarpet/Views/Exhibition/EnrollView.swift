//
//  EnrollView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct EnrollView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var exhibitionTitle: String = ""
    @State private var exhibitionDetail: String = ""
    @State private var hashTags: String = ""
    @State private var date: Date = Date()
    
    @State private var selectedImage1: Image?
    @State private var selectedImage2: Image?
    @State private var selectedImage3: Image?
    @State private var selectedImage4: Image?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color.clear
                VStack(alignment: .leading) {

                    VStack(alignment: .leading) {
                        Text("작품 선택")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                        Text("* 첫번째 사진은 썸네일 화면입니다.")
                            .font(.system(size: 14))
                    }
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ImageSelector() { image in selectedImage1 = image }
                            ImageSelector() { image in selectedImage2 = image }
                            ImageSelector() { image in selectedImage3 = image }
                            ImageSelector() { image in selectedImage4 = image }
                        }
                    }
                    
                    CustomTextField(title: "전시회 제목", placeholder: "전시회 제목을 입력해주세요", text: $exhibitionTitle)
                    
                    CustomTextField(title: "간단한 설명", placeholder: "", text: $exhibitionDetail)
                    
                    CustomTextField(title: "해시태그", placeholder: "", text: $hashTags)
                    
                    VStack(alignment: .leading) {
                        Text("전시회 마감일")
                        VStack {
                            DatePicker("", selection: $date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    }.padding(.top)
                    
                    Spacer()
                    
                    NavigationLink {
                        ExhibitionMainView(
                            thumbnail: $selectedImage1,
                            exhibitionTitle: $exhibitionTitle,
                            exhibitionDetail: $exhibitionDetail,
                            hashTags: .constant(makeTags(raw: hashTags)),
                            date: $date
                        )
                    } label: {
                        Group {
                            Text("전시회 등록하기")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(.black)
                        .cornerRadius(10)
                        .padding(.trailing, 28)
                    }
                }
                .padding(.leading, 31)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    BackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func makeTags(raw: String) -> [String] {
        var hashTags: [String] = []
        for tag in raw.components(separatedBy: " ") {
            if !tag.hasPrefix("#") { continue }
            hashTags.append(tag)
        }
        return hashTags
    }
}

struct EnrollView_Previews: PreviewProvider {
    static var previews: some View {
        EnrollView()
    }
}

extension Color {
    init(_ hex: Int, opacity: Double = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}
