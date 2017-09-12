//
//  ViewController.m
//  PDFTest
//
//  Created by Irena on 07.09.17.
//  Copyright © 2017 Irena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>{
    // Responsible for display PDF file
    WebViewPDF *pdfViewer;
    __weak IBOutlet UITextField *txtSearch;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Do any additional setup after loading the view.
    pdfViewer = [[WebViewPDF alloc] initWithFrame:self.view.bounds];
    CGRect frame = pdfViewer.frame;
    frame.origin.y += 60;
    pdfViewer.frame = frame;
    [self.view addSubview:pdfViewer];
    
    // Disbale scroll bounce
    pdfViewer.scrollView.bounces = NO;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *pdfFilePath = [[NSBundle mainBundle] pathForResource:@"compressed.tracemonkey-pldi-09" ofType:@"pdf"];
    [pdfViewer loadPDF:pdfFilePath];
    
    /*NSString *pdf = [[NSBundle mainBundle] pathForResource:@"compressed.tracemonkey-pldi-09" ofType:@"pdf"];
    NSURL* url = [NSURL URLWithString:pdf];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];*/
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextfield delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [pdfViewer search:textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    {
        [pdfViewer search:finalString];
    }
    return YES;
}

#pragma mark - handel click event
- (IBAction)btnPreviusClicked:(id)sender {
    [pdfViewer previousSearchResult];
}

- (IBAction)btnNextClicked:(id)sender {
    [pdfViewer nextSearchResult];
}

//- (IBAction)btnHighlightedClicked:(UIButton*)sender {
//    [pdfViewer setHighliteSearch:sender.isSelected];
//}
//
//- (IBAction)btnCaseSensitiveClicked:(UIButton*)sender {
//    [pdfViewer setCase

@end
