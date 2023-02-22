//
//  ExhibitionMainView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct ExhibitionMainView: View {
    @Environment(\.dismiss) var dismissAction
    @EnvironmentObject var exhibitionData: ExhibitionData
    @State var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Group {
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    Group {
                        Group {
                            Text(exhibitionData.title)
                                .lineLimit(1...4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 42, weight: .black))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(0x000000, opacity: 0.5))
                        .cornerRadius(10)
                        .padding()
                        
                        NavigationLink {
                            PhotoDisplayView()
                        } label: {
                            Group {
                                Text("관람하기")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .frame(width: 100, height: 50)
                            .background(Color(0xFEFEFE))
                            .cornerRadius(5)
                            .padding()
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    
                    Spacer()
                    
                    Button {
                        showDetail.toggle()
                    } label: {
                        HStack(alignment: .lastTextBaseline) {
                            Image(systemName: "chevron.down")
                            Text("more")
                                .font(.system(size: 20))
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showDetail) {
                        ExhibitionDetailView()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(content: {
                if let photo = exhibitionData.photo1 {
                    photo
                        .resizable()
                        .renderingMode(.original)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ZStack {
                        BackButton {
                            dismissAction.callAsFunction()
                        }
                        
                        Circle()
                            .foregroundColor(Color(0xFFFFFF, opacity: 0.25))
                            .zIndex(-1)
                            .scaleEffect(1.25)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EnrollView(isEdit: .constant(true))
                    } label: {
                        ZStack {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.black)
                            
                            Circle()
                                .foregroundColor(Color(0xFFFFFF, opacity: 0.25))
                                .zIndex(-1)
                                .scaleEffect(1.25)
                        }
                        .padding(.trailing)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ExhibitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionMainView()
            .environmentObject(ExhibitionData())
    }
}
