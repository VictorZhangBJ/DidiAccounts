//
//  ViewController.m
//  DidiAccounts
//
//  Created by victor on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "MyTextCell.h"
#import "SelfTextCell.h"
#import "InputView/InputView.h"

@interface ViewController ()
{
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    NSURL *_audioPlayURL;
    AVAudioRecorder *_audioRecorder;
}

@property (nonatomic, strong) InputView *inputView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"滴滴记账";
    [self initTableView];
    [self initInputView];
    //[self initAudio];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

//录音部分初始化
-(void)initAudio
{
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"audioSesson %@ %ld %@",[error domain], [error code], [[error userInfo] description]);
    }
    
    [audioSession setActive:YES error:&error];
    if (error) {
        NSLog(@"audioSesson %@ %ld %@",[error domain], [error code], [[error userInfo] description]);
    }
    
    //通过可变字典进行配置项的加载
    NSMutableDictionary *setAudioDic = [NSMutableDictionary new];
    
    //设置录音格式
    [setAudioDic setValue:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    
    //设置录音采样率
    [setAudioDic setValue:@(44100) forKey:AVSampleRateKey];
    
    //设置录音通道数
    [setAudioDic setValue:@(2) forKey:AVNumberOfChannelsKey];
    
    //线性采样位数
    [setAudioDic setValue:@(24) forKey:AVLinearPCMBitDepthKey];
    
    //录音的质量
    [setAudioDic setValue:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    
    NSString *cachesURLString = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"caches = %@",cachesURLString);
    
    NSString *filePath = [cachesURLString stringByAppendingPathComponent:@"asreview.pcm"];
    NSLog(@"filePath = %@",filePath);
    
    _audioPlayURL = [NSURL URLWithString:filePath];
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:_audioPlayURL settings:setAudioDic error:&error];
    if (error) {
        NSLog(@"error = %@",error.description);
    }
    
    //开启音量检测
    _audioRecorder.meteringEnabled = YES;
    _audioRecorder.delegate = self;
    
    
}

//初始化iFly SDK
-(void)initFlySpeechRecognizer
{
    // 1.创建语言听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iFlySpeechRecognizer.delegate = self;
    //设置听写模式
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [_iFlySpeechRecognizer setParameter:@"asreview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    [_iFlySpeechRecognizer startListening];
    
}

#pragma - iFly回调
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    
}

-(void)onError:(IFlySpeechError *)errorCode
{
    
}

-(void)onEndOfSpeech
{
    
}

-(void)onBeginOfSpeech
{
    
}

-(void)onVolumeChanged:(int)volume
{
    
}

-(void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView registerClass:[MyTextCell class] forCellReuseIdentifier:@"MyTextCell"];
    //[self.tableView registerNib:[[[NSBundle mainBundle] loadNibNamed:@"SelfTextCell" owner:nil options:nil] lastObject] forCellReuseIdentifier:@"SelfTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelfTextCell" bundle:nil] forCellReuseIdentifier:@"SelfTextCell"];
    self.dataSource = [[NSMutableArray alloc]init];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.inputView.textField resignFirstResponder];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelfTextCell *cell = (SelfTextCell *)[tableView dequeueReusableCellWithIdentifier:@"SelfTextCell" forIndexPath:indexPath];
   
    cell.chatTextLabel.text = self.dataSource[indexPath.row];
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)initInputView{
    self.inputView = [[InputView alloc] init];
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    
//    self.textField = [UITextField new];
//    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.inputView addSubview:self.textField];
//    self.textField.borderStyle = UITextBorderStyleRoundedRect;
//    self.textField.backgroundColor = [UIColor whiteColor];
//    self.textField.placeholder = @"请输入消费内容和金额";
//    
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@40);
//        make.centerX.equalTo(self.inputView.mas_centerX);
//        make.centerY.equalTo(self.inputView.mas_centerY);
//        make.left.equalTo(self.inputView.mas_left).offset(60);
//    }];
//    
//    //语言按钮
//    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [speechBtn addTarget:self action:@selector(speechBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.inputView addSubview:speechBtn];
//    [speechBtn setTitle:@"语音" forState:UIControlStateNormal];
//    [speechBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.inputView.mas_centerY);
//        make.width.equalTo(@60);
//        make.height.equalTo(@40);
//        make.left.equalTo(self.inputView.mas_left);
//    }];
//    
//    //文字按钮
//    UIButton *textInputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [textInputBtn setTitle:@"文字" forState:UIControlStateNormal];
//    [textInputBtn addTarget:self action:@selector(textInputBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.inputView addSubview:textInputBtn];
//    [textInputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@60);
//        make.height.equalTo(@40);
//        make.centerY.equalTo(self.inputView.mas_centerY);
//        make.right.equalTo(self.inputView.mas_right);
//        
//    }];
    
    
}

-(void)speechBtnClick {
    
}

-(void)textInputBtnClick {
    [self.dataSource addObject:self.inputView.textField.text];
    [self.tableView reloadData];
    self.inputView.textField.text = @"";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputView.textField resignFirstResponder];
}

/*
 * 键盘改变了frame时候调用
 */
-(void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    //取出键盘动画的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //取得键盘最后的frame
    CGRect keyFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //控制器view需要移动的距离
    CGFloat transformY = keyFrame.origin.y - self.view.frame.size.height;

    CGRect frame = self.view.frame;
    frame.size.height = keyFrame.origin.y;
    
    CGFloat curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
//        self.inputView.transform = CGAffineTransformMakeTranslation(0, transformY);
//        
//        [UIView setAnimationCurve:curve];
//        self.view.frame = frame;
        NSLog(@"tranfromY = %f",transformY);
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.bottom.equalTo(self.view.mas_bottom).offset(transformY);
            make.centerX.equalTo(self.view.mas_centerX);
            make.left.equalTo(self.view.mas_left);
        }];
        
        //self.tableView.contentOffset = CGPointMake(0, -transformY);
        [self.view layoutIfNeeded];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.inputView.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
