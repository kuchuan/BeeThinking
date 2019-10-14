//
//  PDFViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/09/04.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
//import PDFKit
import Accounts
import GoogleMobileAds

class PDFViewController: UIViewController {
    
//    @IBOutlet weak var PDFView: PDFView!
    @IBOutlet var myText:UITextView!
    @IBOutlet var actionButton:UIBarButtonItem!
    
    @IBOutlet weak var bannerViewPDF: GADBannerView!
    
            //テスト広告ID
    //        let admobId = "ca-app-pub-3940256099942544/2934735716"
            //本番
            let admobId = "ca-app-pub-9383562194881432/7452199597"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myText.text! = "こんにちは！\nこのアプリは\nUITextViewを\npdfで保存できます\n\n\n\n\n\n"
    }
    
    @IBAction func myAction(){
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.view.bounds, nil)
        let pdfContext = UIGraphicsGetCurrentContext()
        myText.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: myText.contentSize)
        UIGraphicsBeginPDFPageWithInfo(myText.frame, nil)
        self.myText.layer.render(in: pdfContext!)
        UIGraphicsEndPDFContext()
        
        let activityItems = [myText.text!,pdfData] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        bannerViewPDF.adUnitID = admobId
        bannerViewPDF.rootViewController = self
        bannerViewPDF.load(GADRequest())
    }
}

//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
////    if; let documentURL = Bundle.main.url(forResource: "sample01", withExtension: "pdf") {
////        if let document = PDFDocument(url: documentURL) {
////            PDFView.document = document
////        }
////    }
//    func renderAsPDF(demandEntry: ParsedDemandEntry, inView view: PDFView) -> NSData? {
//        let entries = demandEntry.demands
//        let pageCount = Int(ceil(Double(entries.count) / Double(demandCountForPage)))
//        if pageCount != 0 {
//            let views = (1...pageCount).map { (pageNumber: Int) -> UIView in
//                let pdfPageView = createTemplatePageViewWithParsedEntry(demandEntry, inView: view)
//
//                let pageRange = ((pageNumber - 1) * demandCountForPage)..<(min(pageNumber * demandCountForPage, entries.count))
//                let entriesForPage = Array(entries[pageRange])
//
//                addEntries(entriesForPage, toView: pdfPageView)
//
//                pdfPageView.removeFromSuperview()
//
//                return pdfPageView
//            }
//
//            return toPDF(views)
//        } else {
//            return nil
//        }
//    }
//
//    private func toPDF(views: [UIView]) -> NSData? {
//
//        if views.isEmpty {
//            return nil
//        }
//
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 612, height: 792), nil)
//
//        let context = UIGraphicsGetCurrentContext()
//
//        for view in views {
//            UIGraphicsBeginPDFPage()
//            view.layer.render(in: context!)
//        }
//
//        UIGraphicsEndPDFContext()
//
//        return pdfData
//    }
//
//    @IBAction func didClickPDF(_ sender: UIButton) {
//
//    }
//}
//
////Dimension UIView: PDFView {
////
////    // Export pdf from Save pdf in drectory and return pdf file path
////    func exportAsPdfFromView() -> String {
////
////        let pdfPageFrame = self.bounds
////        let pdfData = NSMutableData()
////        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
////        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
////        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
////        self.layer.render(in: pdfContext)
////        UIGraphicsEndPDFContext()
////        return self.saveViewPdf(data: pdfData)
////
////    }
////
////    // Save pdf file in document directory
////    func saveViewPdf(data: NSMutableData) -> String {
////
////        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
////        let docDirectoryPath = paths[0]
////        let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
////        if data.write(to: pdfPath, atomically: true) {
////            return pdfPath.path
////        } else {
////            return ""
////        }
////    }
////}
