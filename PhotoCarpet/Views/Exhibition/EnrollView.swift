//
//  EnrollView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct EnrollView: View {
    @Environment(\.dismiss) var dismissAction
    @EnvironmentObject var exhibitionData: ExhibitionData
    @Binding var isEdit: Bool
    
    var body: some View {
        ZStack {
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
                        ImageSelector(price: $exhibitionData.price1 , selectedImage: $exhibitionData.photo1)
                        ImageSelector(price: $exhibitionData.price2 , selectedImage: $exhibitionData.photo2)
                        ImageSelector(price: $exhibitionData.price3 , selectedImage: $exhibitionData.photo3)
                        ImageSelector(price: $exhibitionData.price4 , selectedImage: $exhibitionData.photo4)
                    }
                }
                
                CustomTextField(title: "전시회 제목", placeholder: "전시회 제목을 입력해주세요", text: $exhibitionData.title)
                
                CustomTextField(title: "간단한 설명", placeholder: "설명을 입력해주세요", text: $exhibitionData.description)
                
                CustomTextField(title: "해시태그", placeholder: "태그를 입력해주세요", text: $exhibitionData.rawHashTags)
                
                VStack(alignment: .leading) {
                    Text("전시회 마감일")
                    VStack {
                        DatePicker("", selection: $exhibitionData.date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }
                }.padding(.top)
                
                Spacer()
                Spacer()
                Spacer()
                
                if exhibitionData.isFillData {
                    if !isEdit {
                        NavigationLink() {
                            ExhibitionMainView()
                            // TODO: 전시회 등록 API 호출
                        } label: {
                            Text("전시회 등록하기")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(.black))
                                .cornerRadius(10)
                                .padding(.trailing, 28)
                        }
                    } else {
                        Button {
                            dismissAction.callAsFunction()
                        } label: {
                            Text("전시회 수정하기")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(.black))
                                .cornerRadius(10)
                                .padding(.trailing, 28)
                        }
                    }
                } else {
                    Text("전시회 \(isEdit ? "수정" : "등록")하기")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 18).bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(0x000000, opacity: 0.5))
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
                    dismissAction.callAsFunction()
                    if !isEdit {
                        exhibitionData.clear()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EnrollView_Previews: PreviewProvider {
    static var previews: some View {
        EnrollView(
            isEdit: .constant(false)
        ).environmentObject(ExhibitionData())
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
