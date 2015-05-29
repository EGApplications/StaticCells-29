//
//  EGRegViewController.m
//  StaticCells #29
//
//  Created by Евгений Глухов on 28.05.15.
//  Copyright (c) 2015 EG. All rights reserved.
//

#import "EGRegViewController.h"

@interface EGRegViewController ()

@property (assign, nonatomic) int currentNumberOfField;

@end

// Ключи, под которыми будем хранить соответствующие значения полей

static NSString* kSettingsName = @"Name";
static NSString* kSettingsSurname = @"Surname";
static NSString* kSettingsNickname = @"Nickname";
static NSString* kSettingsPassword = @"Password";
static NSString* kSettingsAge = @"Age";
static NSString* kSettingsPhoneNumber = @"PhoneNumber";
static NSString* kSettingsEmail = @"Email";
static NSString* kSettingsSubscribe = @"Subscribe";
static NSString* kSettingsReceivingNews = @"ReceivingNews";
static NSString* kSettingsNewsAmount = @"NewsAmount";

@implementation EGRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self.mainTextFields objectAtIndex:0] becomeFirstResponder];
    
    [self loadSettings]; // загружаем настройки
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save & Load Settings

- (void) saveSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Кладем значения, которые хотим сохранить после перезапуска, под соответствующими ключами
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:0] text] forKey:kSettingsName];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:1] text] forKey:kSettingsSurname];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:2] text] forKey:kSettingsNickname];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:3] text] forKey:kSettingsPassword];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:4] text] forKey:kSettingsAge];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:5] text] forKey:kSettingsPhoneNumber];
    
    [userDefaults setObject:[[self.mainTextFields objectAtIndex:6] text] forKey:kSettingsEmail];
    
    [userDefaults setBool:self.subscribeSwitch.isOn forKey:kSettingsSubscribe];
    
    [userDefaults setInteger:self.receivingNewsControl.selectedSegmentIndex forKey:kSettingsReceivingNews];
    
    [userDefaults setDouble:self.newsPerDaySlider.value forKey:kSettingsNewsAmount];
    
    [userDefaults synchronize]; // значения будут сохраняться даже после вылета приложения
    
    
}

- (void) loadSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Ставим сохраненные значения под соответствующими полями.
    
    [[self.mainTextFields objectAtIndex:0] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsName]]];
    
    [[self.mainTextFields objectAtIndex:1] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsSurname]]];
    
    [[self.mainTextFields objectAtIndex:2] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsNickname]]];
    
    [[self.mainTextFields objectAtIndex:3] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsPassword]]];
    
    [[self.mainTextFields objectAtIndex:4] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsAge]]];
    
    [[self.mainTextFields objectAtIndex:5] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsPhoneNumber]]];
    
    [[self.mainTextFields objectAtIndex:6] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kSettingsEmail]]];
    
    self.subscribeSwitch.on = [userDefaults boolForKey:kSettingsSubscribe];
    
    self.receivingNewsControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsReceivingNews];
    
    self.newsPerDaySlider.value = [userDefaults doubleForKey:kSettingsNewsAmount];
    
    
    
    self.newsCountLabel.text = [NSString stringWithFormat:@"%1.0f", self.newsPerDaySlider.value];
    
}


#pragma mark - My Methods

- (void) setStandardLabels:(UITextField*) textField withCounter:(int) counter {
    // метод ставит лейблы по умолчанию, если в соответствующий textfield ничего не написано, то есть длина текста равняется 0
    
    if ([textField.text length] == 0) {
        
        switch (counter) {
                
            case 0:
                
                [[self.mainLabels objectAtIndex:0] setText:@"Name"];
                
                break;
                
            case 1:
                
                [[self.mainLabels objectAtIndex:1] setText:@"Surname"];
                
                break;
                
            case 2:
                
                [[self.mainLabels objectAtIndex:2] setText:@"Nickname"];
                
                break;
                
            case 3:
                
                [[self.mainLabels objectAtIndex:3] setText:@"Password"];
                
                break;
                
            case 4:
                
                [[self.mainLabels objectAtIndex:4] setText:@"Age"];
                
                break;
                
            case 5:
                
                [[self.mainLabels objectAtIndex:5] setText:@"Phone number"];
                
                break;
                
            case 6:
                
                [[self.mainLabels objectAtIndex:6] setText:@"email"];
                
                break;
                
            default:
                break;
        }
        
    }
    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField { // метод вызывается при нажатии кнопки return
    
    if ([textField isEqual:[self.mainTextFields objectAtIndex:self.currentNumberOfField]] && self.currentNumberOfField != 6) {
        
        self.currentNumberOfField++;
        
        [[self.mainTextFields objectAtIndex:self.currentNumberOfField] becomeFirstResponder];
        // следующее поле становится активным
    }
    
    else {
        
        [[self.mainTextFields objectAtIndex:self.currentNumberOfField] resignFirstResponder];
        // убирание фокуса с текущего (т.е. последнего) поля
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField { // метод вызывается, как только курсор ставится в textfield
    
    self.currentNumberOfField = (int)[self.mainTextFields indexOfObject:textField]; // индекс поля в массиве, по которому кликнули
    
    for (int i = 0; i < [self.mainTextFields count]; i++) {
        
        if ([[[self.mainTextFields objectAtIndex:i] text] length] == 0) {
            
            [self setStandardLabels:[self.mainTextFields objectAtIndex:i] withCounter:i];
            // Проверка всех текстфилдов, пустые ли они, если да, ставятся лейблы по умолчанию
        }
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField { // метод вызывается при нажатии clear button
    
    textField.text = @"";
    
    [self setStandardLabels:textField withCounter:self.currentNumberOfField];
    // также выставляем умолчания
    
    return NO;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { // метод вызывается при каждом изменении строки
    
    if ([textField isEqual:[self.mainTextFields objectAtIndex:5]]) {
        // Если мы находимся в поле ввода номера телефона...
        
        // Вывод в лейблы написанного в текстовых полях
        int i = (int)[self.mainTextFields indexOfObject:textField];
        
        NSString* checkString = [textField.text stringByAppendingString:string];
        
        if ([string length] != 1) { // условие, когда удаляем символы
            
            checkString = [checkString substringToIndex:[checkString length] - 1];
            
        }
        
        // код для форматирования номера телефона. // ====== код Алексея ======
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) { // Если components будет содержать символ, тогда он будет разделением для чисел, тогда ничего не выводим, так как будет 2 объекта в массиве, нужны только числа
            
            return NO;
            
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];
        
        NSMutableString* resultString = [NSMutableString string];
        
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 3;
        
        // Делаем локальный номер (ХХХ-ХХХХ)
        
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        if (localNumberLength > 0) {
            
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                
                [resultString insertString:@"-" atIndex:3];
                
            }
            
        }
        
        // Делаем код региона (ХХХ)
        
        if ([newString length] > localNumberMaxLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ", area];
            
            [resultString insertString:area atIndex:0];
            
        }
        
        // Делаем код страны (+ХХХ)
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString* countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
            
        }
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            
            return NO;
            
        }
        
        textField.text = resultString;
        
        // === код Алексея закончен! ===
        
        [[self.mainLabels objectAtIndex:i] setText:resultString];
        
        return NO;
        
        
    }
    
    else if ([textField isEqual:[self.mainTextFields objectAtIndex:6]]) {
        
        // код для разумного ввода email адреса!
        
        // Вывод в лейблы написанного в текстовых полях
        int i = (int)[self.mainTextFields indexOfObject:textField];
        
        NSString* checkString = [textField.text stringByAppendingString:string];
        
        if ([string length] != 1) { // условие, когда удаляем символы
            
            checkString = [checkString substringToIndex:[checkString length] - 1];
            
        }
        
        NSCharacterSet* atSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        NSCharacterSet* illegalSet = [NSCharacterSet characterSetWithCharactersInString:@" !#$%^&*()=+\"№;:?[]~`|{}/'"];
        
        NSArray* atComponents = [checkString componentsSeparatedByCharactersInSet:atSet];
        NSArray* illegalComponents = [checkString componentsSeparatedByCharactersInSet:illegalSet];
        
        if ([atComponents count] > 2 || [illegalComponents count] > 1) { // собака вводится только один раз (по аналогии с цифрами в номере телефона в коде Алексея), а также нельзя вводить недопустимые символы (illegal set)
            
            return NO;
            
        }
        
        [[self.mainLabels objectAtIndex:i] setText:checkString];
        
        return [checkString length] <= 23; // длина email не больше 19 символов
        
    }
    
    else {
        
        // Вывод в лейблы написанного в текстовых полях
        int i = (int)[self.mainTextFields indexOfObject:textField];
        
        NSString* checkString = [textField.text stringByAppendingString:string];
        
        if ([string length] != 1) { // условие, когда удаляем символы
            
            checkString = [checkString substringToIndex:[checkString length] - 1];
            
        }
        
        [[self.mainLabels objectAtIndex:i] setText:checkString];
        
        return YES;
        
    }
    
}

#pragma mark - Actions

- (IBAction)subscriptionActions:(id)sender {
    
    if ([sender isEqual:self.newsPerDaySlider]) {
        
        self.newsCountLabel.text = [NSString stringWithFormat:@"%1.0f", self.newsPerDaySlider.value];
        
    }
    
    [self saveSettings]; // сохраняем сюда значения слайдера, свитча и сегментед контрола.
    
}

- (IBAction)actionTextFieldChanged:(UITextField *)sender {
    
    [self saveSettings]; // сохраняем значения текстовых полей
    
}


@end
