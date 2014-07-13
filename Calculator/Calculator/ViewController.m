//
//  ViewController.m
//  Calculator
//
//  Created by Jackie Chun on 7/13/14.
//  Copyright (c) 2014 Jackie Chun. All rights reserved.
//

#import "ViewController.h"
#include "DDMathParser.h"
#include "DDMathStringTokenizer.h"
#include <ctype.h>

@interface ViewController (){
    NSMutableString* mem;
    BOOL resetFlag;
    char cbuf[100];
    DDMathEvaluator *evaluator;
	double memoryNumber;
	double currentNumber;
    __weak IBOutlet UILabel *display;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	mem = [NSMutableString stringWithFormat:@"0"];
    resetFlag = YES;
    evaluator = [[DDMathEvaluator alloc] init];
	memoryNumber = 0;
	currentNumber = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onNumButtonTap:(id)sender {
    UIButton* button = (UIButton*)sender;
	NSString* numText = [button currentTitle];
	if(resetFlag){
		[mem setString:numText];
		resetFlag = NO;
	} else {
		[mem appendString:numText];
	}
	
}
- (IBAction)onFuncButtonTap:(id)sender {
    UIButton* button = (UIButton*)sender;
	NSString* text = [button currentTitle];
	if([text isEqualToString:@"÷"]){
		text = @"/";
	}
	if([text isEqualToString:@"x"]){
		text = @"*";
	}
	if([text isEqualToString:@"–"]){
		text = @"-";
	}
	if([text isEqualToString:@"("] && resetFlag){
		text = @"";
		[mem setString:@"("];
	}
	[mem appendString:text];
	resetFlag = NO;
}
- (IBAction)updateLabel:(id)sender {
    [display setText:mem];

}
- (IBAction)clearButtonTap:(id)sender {
    [mem setString:@"0"];
	resetFlag = YES;
}
- (IBAction)negativeButtonTap:(id)sender {
    if([MathUtil isNagtive:mem]){
		[mem setString:[mem substringFromIndex:1]];
	} else{
		[mem insertString:@"-" atIndex:0];
	}
}
- (IBAction)percentButtonTap:(id)sender {
    // must calculate first!
	[mem getCString:cbuf maxLength:100 encoding:NSUTF8StringEncoding];
	double dbuf = atof(cbuf);
	dbuf = dbuf / 100;
	[mem setString:[NSString stringWithFormat:@"%f", dbuf]];
}
- (IBAction)dotButtonTap:(id)sender {
    if(![MathUtil isRealNum:mem]){
		[mem appendString:@"."];
	}
}
- (IBAction)equalButtonTap:(id)sender {
    [self calculate];
	resetFlag = YES;
}

- (void)calculate{
	NSString* expressionString = mem;
	NSLog(@"Exp : %@", expressionString);
	NSError *error = nil;
	DDMathStringTokenizer *tokenizer = [[DDMathStringTokenizer alloc] initWithString:expressionString error:&error];
	DDParser *parser = [DDParser parserWithTokenizer:tokenizer error:&error];
	
	DDExpression *expression = [parser parsedExpressionWithError:&error];
	DDExpression *rewritten = [evaluator expressionByRewritingExpression:expression];
	
	NSNumber *value = [rewritten evaluateWithSubstitutions:nil evaluator:evaluator error:&error];
    
	currentNumber = [value doubleValue];
	DD_RELEASE(tokenizer);
	NSString* valueString = [value description];
	
	
	[mem setString:valueString];
}

@end
